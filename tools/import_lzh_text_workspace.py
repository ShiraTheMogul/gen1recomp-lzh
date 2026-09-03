#!/usr/bin/env python3
"""Import the Literary Chinese translation workspace into pokered-lzh.

The importer is keyed by the ``Text Label`` column, not spreadsheet row number.
It accepts the current ``Translation Workspace`` sheet and the older
``Text Workspace`` name for backwards compatibility.

By default, only rows with Import = Yes are emitted. With ``--include-drafts``,
rows whose Status is Draft are also emitted so unfinished translations can be
reviewed in-game. Rows whose ``Managed By`` value is ``String Catalog`` use
``Text Label`` as an engine-string source key and are emitted through
``mod.content.strings``; all other rows remain ROM text-label overrides. The
script edits one bracketed, auto-generated block in mods/pokered-lzh/main.lua
and leaves hand-written localisation code alone.

The XLSX reader uses only Python's standard library; no pip packages are needed.
"""
from __future__ import annotations

import argparse
import posixpath
import re
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

SHEET_NAMES = ("Translation Workspace", "Text Workspace")
BEGIN = "  -- BEGIN AUTO-GENERATED TEXT WORKSPACE"
END = "  -- END AUTO-GENERATED TEXT WORKSPACE"
INSERT_ANCHOR = "  -- Red/Blue are characters as well as version colours."

NS_MAIN = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
NS_REL_DOC = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
NS_REL_PKG = "http://schemas.openxmlformats.org/package/2006/relationships"

TOKEN_RE = re.compile(r"\{[^{}]+\}|%(?:\d+\$)?[-+0 #]*\d*(?:\.\d+)?[sd]")
CELL_RE = re.compile(r"^([A-Z]+)(\d+)$")


def col_number(letters: str) -> int:
    n = 0
    for ch in letters:
        n = n * 26 + (ord(ch) - 64)
    return n


def shared_strings(zf: zipfile.ZipFile) -> list[str]:
    name = "xl/sharedStrings.xml"
    if name not in zf.namelist():
        return []
    root = ET.fromstring(zf.read(name))
    out = []
    for si in root.findall(f"{{{NS_MAIN}}}si"):
        out.append("".join(t.text or "" for t in si.iter(f"{{{NS_MAIN}}}t")))
    return out


def find_sheet(zf: zipfile.ZipFile) -> tuple[str, str]:
    wb = ET.fromstring(zf.read("xl/workbook.xml"))
    sheets = wb.find(f"{{{NS_MAIN}}}sheets")
    if sheets is None:
        raise ValueError("workbook has no sheets")

    available: dict[str, str] = {}
    for sh in sheets:
        name = sh.attrib.get("name", "")
        rid = sh.attrib.get(f"{{{NS_REL_DOC}}}id")
        if name and rid:
            available[name] = rid

    wanted = next((name for name in SHEET_NAMES if name in available), None)
    if wanted is None:
        raise ValueError(
            "workbook has no supported translation sheet; expected one of: "
            + ", ".join(repr(x) for x in SHEET_NAMES)
        )

    rid = available[wanted]
    rels = ET.fromstring(zf.read("xl/_rels/workbook.xml.rels"))
    target = None
    for rel in rels.findall(f"{{{NS_REL_PKG}}}Relationship"):
        if rel.attrib.get("Id") == rid:
            target = rel.attrib.get("Target")
            break
    if not target:
        raise ValueError(f"could not resolve relationship for sheet {wanted!r}")
    if target.startswith("/"):
        return wanted, target.lstrip("/")
    return wanted, posixpath.normpath(posixpath.join("xl", target))


def read_workspace(path: Path) -> tuple[str, list[dict[str, str]]]:
    with zipfile.ZipFile(path) as zf:
        strings = shared_strings(zf)
        sheet_name, spath = find_sheet(zf)
        root = ET.fromstring(zf.read(spath))
        sheet_data = root.find(f"{{{NS_MAIN}}}sheetData")
        if sheet_data is None:
            raise ValueError(f"{sheet_name} has no sheetData")

        sparse_rows: list[dict[int, str]] = []
        for row in sheet_data.findall(f"{{{NS_MAIN}}}row"):
            values: dict[int, str] = {}
            for cell in row.findall(f"{{{NS_MAIN}}}c"):
                ref = cell.attrib.get("r", "")
                m = CELL_RE.match(ref)
                if not m:
                    continue
                col = col_number(m.group(1))
                ctype = cell.attrib.get("t")
                value = ""
                if ctype == "inlineStr":
                    is_el = cell.find(f"{{{NS_MAIN}}}is")
                    if is_el is not None:
                        value = "".join(t.text or "" for t in is_el.iter(f"{{{NS_MAIN}}}t"))
                else:
                    v = cell.find(f"{{{NS_MAIN}}}v")
                    raw = v.text if v is not None and v.text is not None else ""
                    if ctype == "s" and raw:
                        value = strings[int(raw)]
                    elif ctype == "b":
                        value = "TRUE" if raw == "1" else "FALSE"
                    else:
                        value = raw
                values[col] = value
            sparse_rows.append(values)

    if not sparse_rows:
        raise ValueError(f"{sheet_name} is empty")

    headers = {col: value.strip() for col, value in sparse_rows[0].items() if value.strip()}
    required = {"Text Label", "English (clean ROM)", "Translation", "Import"}
    present = set(headers.values())
    missing = required - present
    if missing:
        raise ValueError(f"{sheet_name} is missing columns: {', '.join(sorted(missing))}")

    rows: list[dict[str, str]] = []
    for sparse in sparse_rows[1:]:
        row = {header: sparse.get(col, "") for col, header in headers.items()}
        if any(str(v).strip() for v in row.values()):
            rows.append(row)
    return sheet_name, rows


def decode_layout(value: str) -> str:
    """Convert spreadsheet-visible layout escapes into semantic characters."""
    value = str(value).replace("\r\n", "\n").replace("\r", "\n")
    value = value.replace(r"\f", "\x0c").replace(r"\v", "\x0b").replace(r"\n", "\n")
    return value


def lua_quote(value: str) -> str:
    value = decode_layout(value)
    value = value.replace("\\", "\\\\").replace('"', '\\"')
    value = value.replace("\x0c", r"\f").replace("\x0b", r"\v").replace("\n", r"\n")
    return '"' + value + '"'


def token_multiset(value: str) -> list[str]:
    return sorted(TOKEN_RE.findall(decode_layout(value)))


def selected_rows(workbook: Path, include_drafts: bool = False):
    sheet_name, rows = read_workspace(workbook)
    if include_drafts and rows and "Status" not in rows[0]:
        raise ValueError("--include-drafts requires a Status column")
    selected = []
    errors = []
    seen = {}
    for sheet_row, row in enumerate(rows, start=2):
        flag = str(row.get("Import", "")).strip().lower()
        status = str(row.get("Status", "")).strip()
        import_selected = flag in {"yes", "y", "true", "1"}
        draft_selected = include_drafts and status.lower() == "draft"
        if not (import_selected or draft_selected):
            continue

        label = str(row.get("Text Label", "")).strip()
        source = str(row.get("English (clean ROM)", ""))
        translation = str(row.get("Translation", ""))
        area = str(row.get("Test Area", "")).strip()
        managed_by = str(row.get("Managed By", "")).strip().lower()
        target_kind = "string" if managed_by == "string catalog" else "text"

        where = f"{sheet_name} row {sheet_row}"
        reason = "Import=Yes" if import_selected else "Status=Draft"
        if not label:
            errors.append(f"{where}: selected by {reason} but Text Label is blank")
            continue
        if not translation.strip():
            errors.append(f"{where} {label}: selected by {reason} but Translation is blank")
            continue
        seen_key = (target_kind, label)
        if seen_key in seen:
            errors.append(
                f"{where} {label}: duplicate {target_kind} key; "
                f"first imported at row {seen[seen_key]}"
            )
            continue
        seen[seen_key] = sheet_row

        src_tokens = token_multiset(source)
        dst_tokens = token_multiset(translation)
        if src_tokens != dst_tokens:
            errors.append(
                f"{where} {label}: placeholder mismatch\n"
                f"  source:      {src_tokens}\n"
                f"  translation: {dst_tokens}"
            )
            continue

        selected.append((target_kind, label, translation, area, status, sheet_row))
    return sheet_name, selected, errors, len(rows)


def build_block(rows, workbook_name: str, include_drafts: bool = False) -> str:
    selection_note = "Import=Yes plus Status=Draft" if include_drafts else "Import=Yes"
    text_rows = [row for row in rows if row[0] == "text"]
    string_rows = [row for row in rows if row[0] == "string"]
    out = [
        BEGIN,
        f"  -- Generated by tools/import_lzh_text_workspace.py from {workbook_name}.",
        f"  -- Selection: {selection_note}.",
        "  -- Edit the workbook and re-run the importer; do not hand-edit this block.",
        "  local workspaceText = {",
    ]
    for _, label, translation, area, status, _ in text_rows:
        detail = area or status
        comment = f" -- {detail}" if detail else ""
        out.append(f"    [{lua_quote(label)}] = {lua_quote(translation)},{comment}")
    out += [
        "  }",
        "  for id, text in pairs(workspaceText) do",
        "    mod.content.text:override(id, text)",
        "  end",
    ]
    if string_rows:
        out.append("  local workspaceStrings = {")
        for _, source, translation, area, status, _ in string_rows:
            detail = area or status
            comment = f" -- {detail}" if detail else ""
            out.append(f"    [{lua_quote(source)}] = {lua_quote(translation)},{comment}")
        out += [
            "  }",
            "  for source, text in pairs(workspaceStrings) do",
            "    mod.content.strings:override(source, text)",
            "  end",
        ]
    out.append(END)
    return "\n".join(out) + "\n"


def replace_block(main_text: str, block: str) -> str:
    has_begin = BEGIN in main_text
    has_end = END in main_text
    if has_begin != has_end:
        raise ValueError("main.lua contains only one workspace marker; repair the marker pair first")
    if has_begin:
        start = main_text.index(BEGIN)
        finish = main_text.index(END, start) + len(END)
        if finish < len(main_text) and main_text[finish] == "\n":
            finish += 1
        return main_text[:start] + block + main_text[finish:]
    if INSERT_ANCHOR not in main_text:
        raise ValueError("could not find the normal insertion anchor in main.lua")
    return main_text.replace(INSERT_ANCHOR, block + "\n" + INSERT_ANCHOR, 1)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("workbook", type=Path)
    ap.add_argument("main_lua", type=Path)
    ap.add_argument("--check", action="store_true", help="validate only; do not modify main.lua")
    ap.add_argument(
        "--include-drafts",
        action="store_true",
        help="also import rows whose Status is Draft, even when Import is not Yes",
    )
    args = ap.parse_args()

    try:
        sheet_name, rows, errors, total = selected_rows(args.workbook, args.include_drafts)
    except (OSError, ValueError, zipfile.BadZipFile, KeyError, IndexError) as exc:
        print(f"workspace error: {exc}", file=sys.stderr)
        return 2

    print(f"workspace sheet: {sheet_name}")
    print(f"workspace rows: {total}")
    if args.include_drafts:
        print("selection: Import=Yes plus Status=Draft")
    else:
        print("selection: Import=Yes")
    print(f"selected for import: {len(rows)}")
    if errors:
        print("\n".join(errors), file=sys.stderr)
        print(f"validation failed: {len(errors)} error(s)", file=sys.stderr)
        return 1
    if args.check:
        print("validation OK")
        return 0

    try:
        original = args.main_lua.read_text(encoding="utf-8-sig")
        updated = replace_block(original, build_block(rows, args.workbook.name, args.include_drafts))
        args.main_lua.write_text(updated, encoding="utf-8-sig", newline="\n")
    except (OSError, ValueError) as exc:
        print(f"main.lua error: {exc}", file=sys.stderr)
        return 2

    print(f"wrote {args.main_lua}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
