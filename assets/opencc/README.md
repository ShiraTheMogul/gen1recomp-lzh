# OpenCC display dictionaries

These data files are vendored from [OpenCC](https://github.com/BYVoid/OpenCC)
for the Literary Chinese display-variant switch. They were retrieved from the
upstream `master` branch on 2026-08-16.

The runtime intentionally stays pure Lua: `src/core/CharacterVariant.lua`
loads these source dictionaries directly instead of linking the native OpenCC
library. This keeps the same feature available in packaged desktop, mobile,
handheld, and console builds without adding a platform-specific native binary.

Used conversion data:

- `CJK_Compatibility_Ideographs.txt` — OpenCC's normalization pre-pass.
- `TSPhrases.txt` and `TSCharacters.txt` — Traditional to Simplified.
  OpenCC’s generated `TSCharactersExt` tofu-risk layer is deliberately not
  used: it can replace rare but supported source characters with Extension-B+
  simplified forms absent from the bundled Wenjin font (for example
  `䝻` → `𧹕`). Preserving the readable source glyph is preferable to drawing
  a missing-glyph box. This follows the same practical omission documented by
  `opencc-js` for browser/system-font compatibility.
- `JPShinjitaiCharacters.txt` — OpenCC's Shinjitai-to-kyujitai table; the
  runtime reverses it, matching the role of OpenCC's generated
  `JPShinjitaiCharactersRev` table used by `t2jp.json`.

OpenCC and these dictionary files are licensed under Apache-2.0. See `LICENSE`.
