-- Pokémon status screen, laid out like the original's two pages
-- (engine/pokemon/status_screen.asm): page 1 = pic, No., HP bar,
-- STATUS/, the ATTACK/DEFENSE/SPEED/SPECIAL box and TYPE1/TYPE2/
-- IDNo/OT; page 2 = EXP and the moves with PP.  A flips pages, B (or
-- A on page 2) closes.

local Font = require("src.render.Font")
local HanNumber = require("src.render.HanNumber")
-- status_screen.asm PrintMonType prints the type's DISPLAY name from the
-- TypeNames table, not the constant: species types are stored as pokered
-- constants (RomExtractor:typesById) and PSYCHIC's is "PSYCHIC_TYPE" (so it
-- won't collide with the PSYCHIC move), which would overflow the TYPE field.
-- TypeChart.displayName maps it back to "PSYCHIC", like HallOfFame and the
-- battle move-type box already do (#214).
local TypeChart = require("src.battle.TypeChart")
local Strings = require("src.core.Strings")
local Stats = require("src.pokemon.Stats")
local Status = require("src.battle.Status")

local SummaryMenu = {}
SummaryMenu.__index = SummaryMenu
SummaryMenu.isOpaque = true

-- SGB: SetPal_StatusScreen -- HP-bar palette overall, mon pic zone in
-- the species palette
function SummaryMenu:sgbPalettes(game)
  local P = require("src.render.PaletteFX")
  local mon = self.mon
  if not mon then return P.wholeNamed(game.data, "MEWMON") end
  local bar = P.pal(game.data, P.barPalName(mon.hp, mon.stats.hp))
  if not bar then return nil end
  return { P.whole(bar), P.zone(P.monPal(game.data, mon.species), 1, 0, 7, 6) }
end

function SummaryMenu.new(game, mon)
  -- status_screen.asm:66-76: StatusScreen recalculates the stat block before
  -- it draws anything when the mon came from a box or the daycare ("mon is
  -- in a box or daycare" -> CalcStats), because box_struct carries none.
  -- Bill's PC hands us that mon table directly (src/ui/BoxMenu.lua's STATS
  -- submenu entry), and for a .sav imported through
  -- src/save_convert/GenSave.lua it really does arrive with mon.stats nil,
  -- which crashed the HP bar draw below (#233).  Redundant once
  -- SaveData.validate has run over a loaded save, but this is the site the
  -- original recomputes at, and it also covers a mon handed in by a mod.
  Stats.ensure(game.data.pokemon[mon.species], mon)
  local self = setmetatable({ game = game, mon = mon, page = 1 }, SummaryMenu)
  local Sprites = require("src.pokemon.Sprites")
  local path, trueColor = Sprites.path(game.data, mon.species, "front",
    { mon = mon, kind = "summary" })
  if path then
    local ok, img = pcall(love.graphics.newImage, path)
    self.sprite = ok and img or nil
  end
  self.spriteTrueColor = self.sprite and trueColor or false
  require("src.core.Sound").playCry(game.data, mon.species)
  return self
end

function SummaryMenu:update(dt)
  local input = self.game.input
  -- both A and B advance the pages (WaitForTextScrollButtonPress)
  if input:wasPressed("a") or input:wasPressed("b") then
    if self.page == 1 then
      self.page = 2
    else
      self.game.stack:pop()
    end
  end
end

-- DrawLineBox (status_screen.asm): a vertical edge down the right,
-- a corner, a horizontal run leftward and the half-arrow ending --
-- drawn from the same HUD tiles the original loads
local function drawLineBox(tx, ty, b, c)
  local HudTiles = require("src.render.HudTiles")
  -- Under the status screen's overlay the vertical is $78 -- DrawLineBox
  -- writes `ld [hl], $78` (status_screen.asm:222), and :90-93 is what puts
  -- hud_2's single bar tile there.  $73 is the <ID> glyph on this screen,
  -- not a line, so the whole box has to come off statusTile (#280).  The
  -- drawn shapes are unchanged: hud_2 tile 0 is the same bar the battle
  -- layout parks at $73.
  for i = 0, b - 1 do HudTiles.statusTile(0x78, tx * 8, (ty + i) * 8) end
  HudTiles.statusTile(0x77, tx * 8, (ty + b) * 8)
  for i = 1, c do HudTiles.statusTile(0x76, (tx - i) * 8, (ty + b) * 8) end
  HudTiles.statusTile(0x6F, (tx - c - 1) * 8, (ty + b) * 8)
end

-- home/pokemon.asm:335-345 PrintLevel: the "<LV>" (":L") tile at (tx,ty)
-- then the level LEFT_ALIGNed after it; at level 100 hl is decremented so
-- the third digit is written back OVER the ":L" tile.  Both status pages
-- print a level this way, and src/ui/PartyMenu.lua models the same rule for
-- its rows. #280
local function printLevel(tx, ty, level)
  if HanNumber.enabled() then
    HanNumber.drawText(HanNumber.format(level) .. Strings("LEVEL_SUFFIX"),
      tx * 8, ty * 8)
    return
  end
  local HudTiles = require("src.render.HudTiles")
  local x = tx * 8
  if level < 100 then
    HudTiles.statusTile(0x6E, x, ty * 8)
    x = x + 8
  end
  Font.draw(tostring(level), x, ty * 8)
end

local function displayOwner(name)
  if name == "RED" then return Strings("RED") end
  if name == "BLUE" then return Strings("BLUE") end
  return name
end

local function drawHanHeaderName(name, level)
  local meta = HanNumber.format(level) .. Strings("LEVEL_SUFFIX")
  local metaSize = 10
  local metaW = HanNumber.widthText(meta, metaSize)
  local left, right = 72, 148
  local room = right - left - metaW - 3
  local chosen = 10
  for _, size in ipairs({ 14, 12, 10 }) do
    if Font.widthSized(name, size) <= room then
      chosen = size
      break
    end
  end
  if chosen == Font.cellHeight() then
    Font.draw(name, left, 12)
  else
    Font.drawSized(name, left, 12 + math.floor((14 - chosen) / 2), chosen)
  end
  HanNumber.drawRightText(meta, right, 15, metaSize)
end

function SummaryMenu:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", 0, 0, 160, 144)
  local mon = self.mon
  local game = self.game
  local data = game.data
  local def = data.pokemon[mon.species]

  -- shared header: pic (1,0), name (9,1), № + dex number (1,7).  The pic is
  -- MIRRORED -- status_screen.asm:170 draws it through
  -- LoadFlippedFrontSpriteByMonIndex (home/pokemon.asm sets wSpriteFlipped),
  -- the same routine the intro's NIDORINO show-off uses (OakSpeech picFlip:
  -- negative x scale anchored at the pic's right edge). #280
  if self.sprite then
    local pw, ph = self.sprite:getDimensions()
    -- Small front sprites used to sit unnecessarily low, leaving the dex
    -- number trapped against the y=64 stats border.  Bottom-align to y=48;
    -- a full 56x56 species still clamps safely at the top of the screen.
    local py = math.max(0, 48 - ph)
    love.graphics.draw(self.sprite, 8 + pw, py, 0, -1, 1)
    -- a full-color pic has to sit out the SGB monPal recolor, so mark the
    -- rect the mirrored draw covers for the unshaded pass (#430)
    if self.spriteTrueColor then
      require("src.render.PaletteFX").markTrueColor(8, py, pw, ph)
    end
  end
  local HudTiles = require("src.render.HudTiles")
  love.graphics.setColor(0, 0, 0, 1)
  local displayName = mon.nickname or def.name
  if HanNumber.enabled() and self.page == 1 then
    drawHanHeaderName(displayName, mon.level)
  else
    Font.draw(displayName, 72, 8)
  end
  -- status_screen.asm:109-113 backs hl up from DrawLineBox's end to write
  -- the single-tile '№' at (1,7) and '<DOT>' at (2,7); :143-146 then
  -- PrintNumbers the dex number (LEADING_ZEROES, 3 digits) at (3,7).
  -- Spelling "No." out of three letter tiles pushed every digit a column
  -- right of the original. #280
  if HanNumber.enabled() then
    -- Pokédex numbers are identifiers, not quantities: preserve the
    -- cartridge's three decimal places and map each digit independently.
    HanNumber.drawText("第" .. HanNumber.digits(def.dex or 0, 3), 8, 56, 8)
  else
    HudTiles.statusTile(0x74, 8, 56)  -- №
    Font.drawCode(0xF2, 16, 56)       -- <DOT> (charmap.asm:182)
    Font.draw(("%03d"):format(def.dex or 0), 24, 56)
  end

  if self.page == 1 then
    if HanNumber.enabled() then
      -- 16px lexical text needs a different composition from the original
      -- 8px status screen.  Keep names/labels large, but use the compact
      -- numeral face for telemetry and identifiers.
      drawLineBox(19, 1, 6, 10)
      -- The status page already identifies this as the HP block by position;
      -- a 16px 體 only crowds the compact meter, so leave the bar unlabelled.
      HudTiles.drawCappedGauge(data, 96, 24, mon, 1, false, 5)
      HanNumber.drawRightText(HanNumber.pair(mon.hp, mon.stats.hp), 148, 35, 10)

      -- Four 16px rows fit the left statistics box exactly.  Keep the full
      -- lexical face; only the dense numeric values use the compact face.
      -- The number baseline is brought up to the label instead of shrinking
      -- the label to imitate the English status-screen stagger.
      Font.drawBox(0, 8, 10, 10)
      local stats = {
        { "ATTACK", mon.stats.attack }, { "DEFENSE", mon.stats.defense },
        { "SPEED", mon.stats.speed }, { "SPECIAL", mon.stats.special },
      }
      for i, row in ipairs(stats) do
        local y = 72 + (i - 1) * 16
        -- Base 16px Wenjin uses the dialogue/tile baseline and therefore
        -- paints substantially higher than the compact 10px numeral face.
        -- Lower the lexical label instead of shrinking it.
        Font.drawSized(Strings(row[1]), 8, y + 9, 16)
        HanNumber.drawRight(row[2], 72, y + 3, 10)
      end

      -- Put all categorical metadata in one four-row block.  TYPE2 sits
      -- beside TYPE1, which frees a complete row for status and stops a
      -- two-character condition such as 無恙 floating in the header.
      drawLineBox(19, 9, 8, 6)
      local type1 = def.types[1] and TypeChart.displayName(def.types[1]) or ""
      local type2 = def.types[2] and TypeChart.displayName(def.types[2]) or ""
      local types = type1
      if type2 ~= "" and type2 ~= type1 then types = types .. type2 end
      local status = mon.status
      local record = Status.recordFor(data.statuses, status)
      local statusText = status and ((record and record.label) or status) or Strings("OK")

      Font.drawSized(Strings("TYPE1/"), 80, 73, 16)
      Font.drawSized(types, 104, 73, 16)
      Font.drawSized(Strings("STATUS/"), 80, 89, 16)
      Font.drawSized(statusText, 104, 89, 14)
      Font.drawSized(Strings("IDNo/"), 80, 105, 16)
      HanNumber.drawRightText(
        HanNumber.digits(mon.otId or game.save.player.id or 0, 5), 148, 108, 10)
      Font.drawSized(Strings("OT/"), 80, 121, 16)
      Font.drawSized(displayOwner(mon.ot or game.save.player.name or "RED"), 104, 121, 14)
      love.graphics.setColor(1, 1, 1, 1)
      return
    end

    -- HP bar (11,3) + numbers row 4, STATUS/ (9,6), the DrawLineBox
    -- bracket around the name/HP block, and PrintLevel at (14,2).  The
    -- level belongs to page 1 ONLY: StatusScreen2 opens with ClearScreenArea
    -- over (9,2) 5x10 (status_screen.asm:303-305), which wipes it. #280
    printLevel(14, 2, mon.level)
    drawLineBox(19, 1, 6, 10)
    HudTiles.drawHPBar(data, 11, 3, mon, 1) -- wHPBarType 1
    if HanNumber.enabled() then
      HanNumber.drawRightText(HanNumber.pair(mon.hp, mon.stats.hp), 160, 34)
    else
      Font.draw(("%3d/%3d"):format(mon.hp, mon.stats.hp), 96, 32)
    end
    Font.draw(Strings("STATUS/"), 72, 48)
    local status = mon.status
    local record = Status.recordFor(data.statuses, status)
    Font.draw(status and ((record and record.label) or status) or "OK", 128, 48)

    -- stats box (0,8) 10x10: names rows 9/11/13/15, values indented
    Font.drawBox(0, 8, 10, 10)
    local stats = {
      { "ATTACK", mon.stats.attack }, { "DEFENSE", mon.stats.defense },
      { "SPEED", mon.stats.speed }, { "SPECIAL", mon.stats.special },
    }
    for i, s in ipairs(stats) do
      local y = 72 + (i - 1) * 16
      Font.draw(Strings(s[1]), 8, y)
      if HanNumber.enabled() then
        HanNumber.drawRight(s[2], 72, y + 2)
      else
        Font.draw(("%3d"):format(s[2]), 48, y + 8)
      end
    end

    -- TYPE1/TYPE2/IDNo/OT column (10,9) with values indented (11,10)
    drawLineBox(19, 9, 8, 6)
    Font.draw(Strings("TYPE1/"), 80, 72)
    Font.draw(def.types[1] and TypeChart.displayName(def.types[1]) or "", 88, 80)
    if def.types[2] then
      Font.draw(Strings("TYPE2/"), 80, 88)
      Font.draw(TypeChart.displayName(def.types[2]), 88, 96)
    end
    -- TypesIDNoOTText's third row is "<ID>№/" (status_screen.asm:205-210):
    -- two single-tile glyphs and a slash, three columns wide, not the five
    -- letter tiles "IDNo/" this used to spell out. #280
    HudTiles.statusTile(0x73, 80, 104) -- <ID>
    HudTiles.statusTile(0x74, 88, 104) -- №
    Font.draw("/", 96, 104)
    -- the trainer ID is rolled at new game (SaveData.newGame) and
    -- backfilled on load for old saves
    if HanNumber.enabled() then
      HanNumber.drawRight(mon.otId or game.save.player.id or 0, 160, 113)
    else
      Font.draw(("%05d"):format(mon.otId or game.save.player.id or 0), 96, 112)
    end
    Font.draw(Strings("OT/"), 80, 120)
    Font.draw(mon.ot or game.save.player.name or "RED", 96, 128)
  else
    if HanNumber.enabled() then
      -- Page 2 uses the same compact header: the amount of experience is a
      -- quantity, while the four move rows reserve the 16px face for names
      -- and put PP at 10px on the right.
      drawLineBox(19, 1, 6, 10)
      Font.drawSized(Strings("EXP POINTS"), 72, 24, 16)
      HanNumber.drawRight(mon.exp, 148, 29, 10)
      Font.drawSized(Strings("LEVEL UP"), 72, 40, 16)
      local Growth = require("src.pokemon.Growth")
      local nextExp = mon.level < 100
        and (Growth.expForLevel(def.growthRate, mon.level + 1) - mon.exp) or 0
      HanNumber.drawRight(math.max(0, nextExp), 148, 44, 10)

      Font.drawBox(0, 8, 20, 10)
      for i = 1, 4 do
        local mv = mon.moves[i]
        local y = 72 + (i - 1) * 16
        if mv then
          local mdef = data.moves[mv.id]
          Font.drawSized(mdef.name, 8, y + 4, 12)
          local maxPP = mdef.pp + (mv.ppUps or 0) * math.floor(mdef.pp / 5)
          Font.drawSized(Strings("PP"), 64, y + 5, 10)
          HanNumber.drawRightText(HanNumber.pair(mv.pp, maxPP), 148, y + 5, 10)
        else
          Font.draw("－", 8, y)
        end
      end
      love.graphics.setColor(1, 1, 1, 1)
      return
    end

    -- page 2: EXP + the moves with PP (StatusScreen2)
    drawLineBox(19, 1, 6, 10)
    Font.draw(Strings("EXP POINTS"), 72, 24)
    -- PrintNumber at (12,4) with 7 columns: the exp is RIGHT-aligned into
    -- cols 12-18 (status_screen.asm:400-403), not left-aligned from col 12.
    -- #280
    if HanNumber.enabled() then
      HanNumber.drawRight(mon.exp, 160, 34)
    else
      Font.draw(("%7d"):format(mon.exp), 96, 32)
    end
    -- StatusScreen2: "LEVEL UP" at (9,5); next-exp PrintNumber 7 cols at
    -- (7,6); the narrow '<to>' tile at (14,6); PrintLevel at (16,6)
    -- (status_screen.asm:393-403).  The old "%d to L%d" string at x=88
    -- overflowed the DrawLineBox edge.
    Font.draw(Strings("LEVEL UP"), 72, 40)
    local Growth = require("src.pokemon.Growth")
    local nextExp = mon.level < 100
      and (Growth.expForLevel(def.growthRate, mon.level + 1) - mon.exp) or 0
    if HanNumber.enabled() then
      HanNumber.drawRight(math.max(0, nextExp), 120, 50)
    else
      Font.draw(("%7d"):format(math.max(0, nextExp)), 56, 48)
    end
    HudTiles.statusTile(0x70, 112, 48) -- '<to>' at (14,6), was missing (#280)
    printLevel(16, 6, math.min(100, mon.level + 1))
    Font.drawBox(0, 8, 20, 10)
    for i = 1, 4 do
      local mv = mon.moves[i]
      local y = 72 + (i - 1) * 16
      if mv then
        local mdef = data.moves[mv.id]
        Font.draw(mdef.name, 16, y)
        local maxPP = mdef.pp + (mv.ppUps or 0) * math.floor(mdef.pp / 5)
        if HanNumber.enabled() then
          HanNumber.drawText(Strings("PP"), 88, y + 2)
          HanNumber.drawRightText(HanNumber.pair(mv.pp, maxPP), 160, y + 2)
        else
          Font.draw(Strings("PP"), 88, y + 8)
          Font.draw(("%2d/%2d"):format(mv.pp, maxPP), 112, y + 8)
        end
      else
        Font.draw("-", 16, y)
        Font.draw("--", 112, y + 8)
      end
    end
  end
  love.graphics.setColor(1, 1, 1, 1)
end

return SummaryMenu
