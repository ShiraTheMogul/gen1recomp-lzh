-- Small game-native Cangjie 5 composer.
--
-- This deliberately implements only the part a naming screen needs:
--   ASCII Cangjie key -> exact single-character candidates.
-- It does not implement phrases, frequency learning, simplification filters,
-- fuzzy matching, or Rime's processor/segmentor pipeline.
--
-- data/input/cangjie5.lua is generated from Rime's cangjie5.base table and
-- preserves source-table candidate order.

local DICTIONARY = require("data.input.cangjie5")

local Cangjie = {}
Cangjie.__index = Cangjie

Cangjie.MAX_CODE = 5
Cangjie.PAGE_SIZE = 9

Cangjie.ROOT_BY_CODE = {
  a = "日", b = "月", c = "金", d = "木", e = "水", f = "火", g = "土",
  h = "竹", i = "戈", j = "十", k = "大", l = "中", m = "一", n = "弓",
  o = "人", p = "心", q = "手", r = "口", s = "尸", t = "廿", u = "山",
  v = "女", w = "田", x = "難", y = "卜", z = "符",
}

-- Physical QWERTY layout.  The root and Latin pages use these exact positions;
-- only the label changes.  That keeps established Cangjie muscle memory intact.
Cangjie.KEY_ROWS = {
  { "q", "w", "e", "r", "t", "y", "u", "i", "o", "p" },
  { "a", "s", "d", "f", "g", "h", "j", "k", "l" },
  { "z", "x", "c", "v", "b", "n", "m" },
}

function Cangjie.new()
  return setmetatable({ code = "", page = 1 }, Cangjie)
end

function Cangjie:reset()
  self.code = ""
  self.page = 1
end

function Cangjie:push(key)
  key = type(key) == "string" and key:lower() or ""
  if #key ~= 1 or not Cangjie.ROOT_BY_CODE[key] then return false end
  if #self.code >= Cangjie.MAX_CODE then return false end
  self.code = self.code .. key
  self.page = 1
  return true
end

function Cangjie:backspace()
  if #self.code == 0 then return false end
  self.code = self.code:sub(1, -2)
  self.page = 1
  return true
end

function Cangjie:isComposing()
  return #self.code > 0
end

function Cangjie:candidates()
  if self.code == "" then return {} end
  return DICTIONARY[self.code] or {}
end

function Cangjie:pageCount()
  local n = #self:candidates()
  return math.max(1, math.ceil(n / Cangjie.PAGE_SIZE))
end

function Cangjie:setPage(page)
  local pages = self:pageCount()
  self.page = math.max(1, math.min(page or 1, pages))
end

function Cangjie:visibleCandidates()
  local all = self:candidates()
  local first = (self.page - 1) * Cangjie.PAGE_SIZE + 1
  local last = math.min(first + Cangjie.PAGE_SIZE - 1, #all)
  local out = {}
  for i = first, last do out[#out + 1] = all[i] end
  return out
end

function Cangjie:roots()
  local out = {}
  for i = 1, #self.code do
    out[#out + 1] = Cangjie.ROOT_BY_CODE[self.code:sub(i, i)]
  end
  return table.concat(out)
end

function Cangjie:labelFor(key, latin)
  if latin then return key:upper() end
  return Cangjie.ROOT_BY_CODE[key]
end

return Cangjie
