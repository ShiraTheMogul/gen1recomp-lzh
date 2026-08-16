-- Pokédex entry page: front sprite, kind, height/weight and the real
-- dex description (data/pokemon/dex_entries.asm + dex_text.asm).
--
-- `species` may be a species id string, or a table
-- `{ species = id, forceOwned = true }`.  forceOwned mirrors pret's
-- StarterDex (engine/events/starter_dex.asm), which temporarily sets the
-- owned bit so Oak's lab ball previews show height/weight/description
-- without permanently marking the mon owned.
--
-- `onDone` (optional) runs right after the page pops itself, the way a
-- TextBox onDone does; map scripts use it to continue once the player
-- closes the entry (the Fighting Dojo prize balls chain their take-it
-- prompt off it).

local Font = require("src.render.Font")
local HanNumber = require("src.render.HanNumber")
local QingMeasure = require("src.core.QingMeasure")
local TextBox = require("src.render.TextBox")
local Strings = require("src.core.Strings")

local DexEntryMenu = {}
DexEntryMenu.__index = DexEntryMenu
DexEntryMenu.isOpaque = true

-- The English Pokédex gives HT/WT labels and their values separate visual
-- jobs.  Do the same here: 高/重 stay slightly larger, while the actual
-- measurement uses the 10px compact numeral face also used for status-screen
-- HP values.  Extremely long values may fall back to 9px, but no smaller.
local MEASURE_LABEL_SIZE = 12
local MEASURE_VALUE_SIZE = 10
local MEASURE_MIN_SIZE = 9
-- Classification sits between the 16px name and the compact metadata.
-- Twelve pixels keeps Han legible while giving the name a distinct visual
-- tier and avoiding the slight 16px-on-16px collision seen in the old row.
local DEX_KIND_SIZE = 12
-- A handful of longer Literary Chinese entries need a fifth line.  Keep the
-- normal 16px body whenever four lines suffice; shrink only those entries to
-- 15px and start them a little higher so all five lines remain visible.
local DEX_BODY_COMPACT_SIZE = 15
local DEX_BODY_COMPACT_Y = 66

local function drawMeasure(label, value, x, y)
  local labelWidth = Font.widthSized(label, MEASURE_LABEL_SIZE)
  Font.drawSized(label, x, y, MEASURE_LABEL_SIZE)

  local valueX = x + labelWidth
  local maxWidth = 160 - valueX
  local size = MEASURE_VALUE_SIZE
  while size > MEASURE_MIN_SIZE and HanNumber.widthText(value, size) > maxWidth do
    size = size - 1
  end
  HanNumber.drawText(value, valueX, y + 1, size)
end

-- SGB: PalPacket_Pokedex (BROWNMON) + the mon pic zone in its palette
function DexEntryMenu:sgbPalettes(game)
  local P = require("src.render.PaletteFX")
  local base = P.pal(game.data, "BROWNMON")
  if not base then return nil end
  return { P.whole(base),
           P.zone(P.monPal(game.data, self.def and self.def.id), 1, 1, 8, 8) }
end

local function resolveArgs(speciesOrOpts)
  if type(speciesOrOpts) == "table" then
    return speciesOrOpts.species or speciesOrOpts[1],
           speciesOrOpts.forceOwned and true or false
  end
  return speciesOrOpts, false
end

function DexEntryMenu.new(game, speciesOrOpts, onDone)
  local species, forceOwned = resolveArgs(speciesOrOpts)
  local self = setmetatable({ game = game, forceOwned = forceOwned,
                              onDone = onDone }, DexEntryMenu)
  self.def = game.data.pokemon[species]
  local path, trueColor = require("src.pokemon.Sprites").path(
    game.data, species, "front", { kind = "dex" })
  -- `path and pcall(...)` truncates to one value, so img was always nil and
  -- every dex page drew without its pic (#307); the guard has to be a
  -- statement for pcall's second return to survive.
  local ok, img = false, nil
  if path then ok, img = pcall(love.graphics.newImage, path) end
  self.sprite = ok and img or nil
  self.spriteTrueColor = self.sprite and trueColor or false
  require("src.core.Sound").playCry(game.data, species)
  return self
end

function DexEntryMenu:update(dt)
  local input = self.game.input
  if input:wasPressed("a") or input:wasPressed("b") then
    self.game.stack:pop()
    if self.onDone then self.onDone() end
  end
end

function DexEntryMenu:draw()
  DexEntryMenu.render(self.game, self.def, self.sprite, self.forceOwned,
                      self.spriteTrueColor)
end

-- Static entry-page renderer, shared with the printer stand-in
-- (src/core/Printer.lua renders the same page into a PNG the way
-- PrintPokedexEntry rendered it to the Game Boy Printer).
function DexEntryMenu.render(game, def, sprite, forceOwned, trueColor)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", 0, 0, 160, 144)
  if sprite then
    local y = math.max(0, 60 - sprite:getHeight())
    love.graphics.draw(sprite, 8, y)
    -- a full-color pic has to sit out the SGB recolor, so mark its bounds
    -- for the unshaded pass (#350).  The printer path leaves trueColor nil:
    -- it renders to its own PNG canvas, and a mark left behind there would
    -- bleed into the next real frame.
    if trueColor then
      require("src.render.PaletteFX").markTrueColor(8, y, sprite:getDimensions())
    end
  end
  love.graphics.setColor(0, 0, 0, 1)
  Font.draw(def.name, 72, 8)
  local e = def.dexEntry or {}
  -- English R/B prints only the kind string (hlcoord 9,4 PlaceString).
  -- The Literary Chinese translation uses a productive 類 suffix for every
  -- classification.  The source token is deliberately invisible when no
  -- translation supplies it, so vanilla keeps the cartridge presentation.
  local kindSuffix = Strings("DEX KIND SUFFIX")
  if kindSuffix == "DEX KIND SUFFIX" then kindSuffix = "" end
  local kind = (e.kind or "?") .. kindSuffix
  if Font.ttfActive() then
    -- The species name owns the full 16px Wenjin face.  The classification is
    -- secondary metadata, so give it the 12px face used around the measurement
    -- block rather than letting two full-height Han rows scrape each other.
    Font.drawSized(kind, 72, 21, DEX_KIND_SIZE)
  else
    -- Preserve the cartridge layout exactly when no Unicode TTF is active.
    Font.draw(kind, 72, 20)
  end
  -- same number width as the list (constants.dexDigits), so a dex past 999
  -- prints the extra digit everywhere at once
  local digits = (game.data.constants or {}).dexDigits or 3
  if HanNumber.enabled() then
    -- Match the Literary Chinese status screen: 第 marks this as an ordinal
    -- identifier, while digits() preserves the cartridge's fixed-width
    -- leading zeroes instead of reading the dex number as a quantity.
    HanNumber.drawText("第" .. HanNumber.digits(def.dex or 0, digits), 72, 31, 8)
  else
    Font.draw(Strings("No.") .. ("%0" .. digits .. "d"):format(def.dex or 0), 72, 32)
  end
  local owned = forceOwned
    or (game.save.pokedex and game.save.pokedex.owned[def.id])
  -- height/weight print only once owned, like the description
  -- (pokedex.asm: "if the pokemon has not been owned, don't print the
  -- height, weight, or description")
  if owned and e.heightFt then
    if e.heightM then
      -- Non-Gen-I datasets may supply already-localized metric values; keep
      -- their existing renderer rather than silently applying the Qing Red/
      -- Blue convention to data with a different provenance.
      Font.draw((Strings("GR. %.1fm", e.heightM):gsub("(%d)%.(%d)", "%1,%2")), 72, 44)
      Font.draw((Strings("GEW. %.1fkg", e.weightKg or 0):gsub("(%d)%.(%d)", "%1,%2")), 72, 54)
    else
      -- Literary Chinese Red/Blue uses the 1908 營造尺庫平制.  The ROM's
      -- whole-inch and tenth-pound source values are rounded to the nearest
      -- 寸 and 兩 respectively; smaller subdivisions would claim precision
      -- the original data does not contain.
      local h = QingMeasure.lengthFromFeetInches(e.heightFt, e.heightIn or 0)
      local w = QingMeasure.weightFromTenthsPounds(e.weight or 0)

      local height = {}
      if h.zhang > 0 then height[#height + 1] = HanNumber.format(h.zhang) .. "丈" end
      if h.chi > 0 then height[#height + 1] = HanNumber.format(h.chi) .. "尺" end
      if h.cun > 0 then height[#height + 1] = HanNumber.format(h.cun) .. "寸" end
      if #height == 0 then height[1] = HanNumber.format(0) .. "寸" end

      local weight = {}
      if w.jin > 0 then weight[#weight + 1] = HanNumber.format(w.jin) .. "斤" end
      if w.liang > 0 then weight[#weight + 1] = HanNumber.format(w.liang) .. "兩" end
      if #weight == 0 then weight[1] = HanNumber.format(0) .. "兩" end

      -- Keep the metadata block clear of the description below.  The old
      -- coordinates left the bottom of 重/weight grazing the first dex line.
      drawMeasure("高", table.concat(height), 72, 41)
      drawMeasure("重", table.concat(weight), 72, 52)
    end
  end
  local text = owned and e.text and game.data.text[e.text] or nil
  local y = 72
  if text then
    -- The dex used to trust hand-inserted \n/\f markers.  Run the description
    -- through the same pixel-width wrapper as dialogue instead, then flatten
    -- its pages because this screen has no textbox page-advance state.
    local wrapped = TextBox.paginate(text, 18)
    local lines = {}
    for _, page in ipairs(wrapped) do
      for _, line in ipairs(page) do lines[#lines + 1] = line end
    end

    local compact = Font.ttfActive() and #lines > 4
    local lineStep = compact and DEX_BODY_COMPACT_SIZE
      or math.max(10, Font.cellHeight())
    if compact then y = DEX_BODY_COMPACT_Y end

    for _, line in ipairs(lines) do
      if compact then
        Font.drawSized(line, 8, y, DEX_BODY_COMPACT_SIZE)
      else
        Font.draw(line, 8, y)
      end
      y = y + lineStep
      if y >= 144 then break end
    end
  else
    Font.draw(Strings("Data unknown."), 8, y)
  end
  love.graphics.setColor(1, 1, 1, 1)
end

return DexEntryMenu
