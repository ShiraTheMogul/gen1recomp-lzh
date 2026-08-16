-- Literary Chinese Pokédex classification coverage.
-- Run with: texlua tests/engine/dex_classifications_test.lua

local patched = {}
local strings = {}

local function registry(kind)
  return {
    override = function(_, id, value)
      if kind == "strings" then strings[id] = value end
    end,
    patch = function(_, id, patch)
      if kind == "pokemon" then
        patched[id] = patch.dexEntry and patch.dexEntry.kind
      end
    end,
    get = function(_, id)
      if kind == "pokemon" then return { dexEntry = { text = "_" .. id .. "DexEntry" } } end
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
for _ in pairs(patched) do count = count + 1 end
assert(count == 151, ("expected 151 classifications, got %d"):format(count))
assert(#warnings == 0, "classification patch emitted a missing-species warning")
assert(patched.BULBASAUR == "種子")
assert(patched.CHARMANDER == "螭")
assert(patched.PINSIR == "鋸鍬形蟲")
assert(patched.GYARADOS == "殘暴不仁")
assert(patched.MEW == "新種")
assert(strings["DEX KIND SUFFIX"] == "類")

print("151/151 Pokédex classifications + 類 suffix registered")
