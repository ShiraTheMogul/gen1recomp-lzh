-- Literary Chinese Pokédex description coverage.
-- Run with: texlua tests/engine/dex_lzh_entries_test.lua

local pokemon = assert(loadfile("data/generated/pokemon.lua"))()
local dexText = {}
local classifications = {}
local strings = {}

local function registry(kind)
  return {
    override = function(_, id, value)
      if kind == "text" and id:match("DexEntry$") then dexText[id] = value end
      if kind == "strings" then strings[id] = value end
    end,
    patch = function(_, id, patch)
      if kind == "pokemon" and patch.dexEntry then
        classifications[id] = patch.dexEntry.kind
      end
    end,
    get = function(_, id)
      if kind == "pokemon" then return pokemon[id] end
      return nil
    end,
    each = function() return function() return nil end end,
  }
end

local content = setmetatable({}, {
  __index = function(t, key)
    local value = registry(key)
    rawset(t, key, value)
    return value
  end,
})

local warnings = {}
local mod = {
  content = content,
  log = {
    warn = function(_, fmt, ...)
      warnings[#warnings + 1] = string.format(fmt, ...)
    end,
    info = function() end,
  },
}

local entry = assert(loadfile("mods/pokered-lzh/main.lua"))()
entry(mod)

local count = 0
for _ in pairs(dexText) do count = count + 1 end
assert(count == 151, ("expected 151 Pokédex descriptions, got %d"):format(count))
assert(#warnings == 0, "Pokédex description registration emitted a warning")
assert(dexText[pokemon.BULBASAUR.dexEntry.text] == "初生，背植奇種，與身俱長。囊中多子，蓄氣其中，故數日不食亦可。")
assert(dexText[pokemon.CHARIZARD.dexEntry.text] == "振翼能及富士之高，冰川重千六百七十六萬斤，噴火能銷之。有時誤焚林。")
assert(dexText[pokemon.BEEDRILL.dexEntry.text] == "羣飛甚疾。又有二螫於手，且一螫於腹，以三枚鄭重擊敵。")
assert(dexText[pokemon.RAICHU.dexEntry.text]:find("十萬伏特", 1, true))
assert(dexText[pokemon.MEW.dexEntry.text] == "南美洲之神獸，昔謂已絕，今見者漸多，然仍甚稀。毛極細，唯顯微鏡可見；智高，百技皆能學。")
assert(classifications.MEW == "新種")
assert(strings["DEX KIND SUFFIX"] == "類")

print("151/151 Literary Chinese Pokédex descriptions registered")
