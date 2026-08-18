#!/usr/bin/env python3
"""Update the Literary Chinese Pokédex tables in mods/pokered-lzh/main.lua.

The source may be either:
  * the project workbook (.xlsx), using sheet "Pokedex" and columns
    "English", "Syntax-refined Dex", and "Classification"; or
  * a JSON list containing english, syntax_dex, and classification keys.

The script deliberately uses only Python's standard library so it can be run
from a stock checkout without adding a spreadsheet dependency.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

NS = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
REL_NS = {"r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships"}
PKG_REL_NS = {"p": "http://schemas.openxmlformats.org/package/2006/relationships"}


def _col_index(cell_ref: str) -> int:
    letters = re.match(r"[A-Z]+", cell_ref)
    if not letters:
        raise ValueError(f"bad cell reference: {cell_ref!r}")
    value = 0
    for ch in letters.group(0):
        value = value * 26 + (ord(ch) - ord("A") + 1)
    return value - 1


def _shared_strings(zf: zipfile.ZipFile) -> list[str]:
    try:
        root = ET.fromstring(zf.read("xl/sharedStrings.xml"))
    except KeyError:
        return []
    out: list[str] = []
    for si in root.findall("m:si", NS):
        # Rich-text cells can contain several <t> runs.
        out.append("".join(t.text or "" for t in si.findall(".//m:t", NS)))
    return out


def _sheet_path(zf: zipfile.ZipFile, wanted: str) -> str:
    workbook = ET.fromstring(zf.read("xl/workbook.xml"))
    rel_id = None
    for sheet in workbook.findall("m:sheets/m:sheet", NS):
        if sheet.attrib.get("name") == wanted:
            rel_id = sheet.attrib.get("{%s}id" % REL_NS["r"])
            break
    if rel_id is None:
        raise ValueError(f"workbook has no sheet named {wanted!r}")

    rels = ET.fromstring(zf.read("xl/_rels/workbook.xml.rels"))
    target = None
    for rel in rels.findall("p:Relationship", PKG_REL_NS):
        if rel.attrib.get("Id") == rel_id:
            target = rel.attrib.get("Target")
            break
    if not target:
        raise ValueError(f"could not resolve relationship {rel_id!r}")
    target = target.lstrip("/")
    if target.startswith("xl/"):
        return target
    return "xl/" + target


def _xlsx_rows(path: Path, sheet_name: str = "Pokedex") -> list[list[str]]:
    with zipfile.ZipFile(path) as zf:
        shared = _shared_strings(zf)
        root = ET.fromstring(zf.read(_sheet_path(zf, sheet_name)))
        rows: list[list[str]] = []
        for row in root.findall("m:sheetData/m:row", NS):
            cells: dict[int, str] = {}
            max_col = -1
            for cell in row.findall("m:c", NS):
                ref = cell.attrib.get("r", "")
                col = _col_index(ref)
                max_col = max(max_col, col)
                kind = cell.attrib.get("t")
                if kind == "inlineStr":
                    value = "".join(t.text or "" for t in cell.findall(".//m:t", NS))
                else:
                    node = cell.find("m:v", NS)
                    raw = node.text if node is not None and node.text is not None else ""
                    if kind == "s" and raw:
                        value = shared[int(raw)]
                    else:
                        value = raw
                cells[col] = value
            if max_col < 0:
                rows.append([])
            else:
                rows.append([cells.get(i, "") for i in range(max_col + 1)])
        return rows


def _records_from_xlsx(path: Path) -> list[dict[str, str]]:
    rows = _xlsx_rows(path)
    if not rows:
        raise ValueError("Pokedex sheet is empty")
    headers = {name: i for i, name in enumerate(rows[0])}
    required = ["English", "Syntax-refined Dex", "Classification"]
    missing = [name for name in required if name not in headers]
    if missing:
        raise ValueError("Pokedex sheet is missing columns: " + ", ".join(missing))

    out: list[dict[str, str]] = []
    for row in rows[1:]:
        def get(name: str) -> str:
            i = headers[name]
            return row[i].strip() if i < len(row) else ""
        english = get("English")
        if not english:
            continue
        syntax = get("Syntax-refined Dex")
        classification = get("Classification")
        if not syntax or not classification:
            raise ValueError(f"{english}: missing syntax-refined entry or classification")
        out.append({
            "english": english,
            "syntax_dex": syntax,
            "classification": classification,
        })
    return out


def _records(path: Path) -> list[dict[str, str]]:
    if path.suffix.lower() == ".json":
        raw = json.loads(path.read_text(encoding="utf-8"))
        if not isinstance(raw, list):
            raise ValueError("JSON source must be a list")
        out = []
        for row in raw:
            out.append({
                "english": str(row.get("english", "")).strip(),
                "syntax_dex": str(row.get("syntax_dex", "")).strip(),
                "classification": str(row.get("classification", "")).strip(),
            })
        return out
    if path.suffix.lower() == ".xlsx":
        return _records_from_xlsx(path)
    raise ValueError("source must be .xlsx or .json")


def _lua_string(text: str) -> str:
    return text.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")


def _table_keys(lua: str, table_name: str) -> list[str]:
    m = re.search(rf"  local {re.escape(table_name)} = \{{\n(.*?)\n  \}}", lua, re.S)
    if not m:
        raise ValueError(f"could not find local {table_name} table")
    keys = re.findall(r"^\s*([A-Z0-9_]+)\s*=", m.group(1), re.M)
    if not keys:
        raise ValueError(f"local {table_name} has no species keys")
    return keys


def _replace_table(lua: str, table_name: str, body: str) -> str:
    pattern = rf"(  local {re.escape(table_name)} = \{{\n).*?(\n  \}})"
    updated, count = re.subn(pattern, lambda m: m.group(1) + body + m.group(2), lua, count=1, flags=re.S)
    if count != 1:
        raise ValueError(f"could not replace local {table_name} table")
    return updated


def update(source: Path, target: Path, check_only: bool = False) -> bool:
    records = _records(source)
    if len(records) != 151:
        raise ValueError(f"expected 151 Pokédex rows, found {len(records)}")

    lua = target.read_text(encoding="utf-8")
    class_keys = _table_keys(lua, "dexClassifications")
    entry_keys = _table_keys(lua, "dexEntries")
    if class_keys != entry_keys:
        raise ValueError("dexClassifications and dexEntries species order differ")
    if len(entry_keys) != len(records):
        raise ValueError(
            f"main.lua has {len(entry_keys)} species keys but source has {len(records)} rows"
        )

    width = max(len(key) for key in entry_keys)
    class_lines = []
    entry_lines = []
    for number, (key, row) in enumerate(zip(entry_keys, records), 1):
        if not row["english"] or not row["syntax_dex"] or not row["classification"]:
            raise ValueError(f"row {number}: incomplete data")
        class_lines.append(
            f'    {key:<{width}} = "{_lua_string(row["classification"])}", -- {number:03d}'
        )
        entry_lines.append(
            f'    {key:<{width}} = "{_lua_string(row["syntax_dex"])}", -- {number:03d}'
        )

    updated = _replace_table(lua, "dexClassifications", "\n".join(class_lines))
    updated = _replace_table(updated, "dexEntries", "\n".join(entry_lines))
    changed = updated != lua
    if check_only:
        return changed
    if changed:
        target.write_text(updated, encoding="utf-8")
    return changed


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="project .xlsx or exported JSON")
    parser.add_argument(
        "target", type=Path, nargs="?", default=Path("mods/pokered-lzh/main.lua"),
        help="main.lua to update (default: mods/pokered-lzh/main.lua)",
    )
    parser.add_argument("--check", action="store_true", help="exit 1 if target is not up to date")
    args = parser.parse_args()
    try:
        changed = update(args.source, args.target, args.check)
    except (OSError, ValueError, KeyError, zipfile.BadZipFile, ET.ParseError) as exc:
        print(f"update_lzh_dex: {exc}", file=sys.stderr)
        return 2
    if args.check:
        if changed:
            print("Pokédex tables are out of date")
            return 1
        print("Pokédex tables are up to date")
        return 0
    print("updated" if changed else "already up to date")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
