-- Runtime Han-character display variants for the Literary Chinese build.
--
-- Source text stays canonical Traditional.  This module is presentation-only:
-- it converts a string immediately before layout/drawing, so scripts, saves,
-- registry ids, and translation source never get rewritten as Simplified or
-- Shinjitai text.
--
-- The dictionaries under assets/opencc are vendored from OpenCC.  We read the
-- source .txt tables directly rather than linking libopencc, keeping the option
-- portable anywhere LÖVE runs (desktop/mobile/handheld/console builds).

local CharacterVariant = {}

CharacterVariant.MODES = { "traditional", "simplified", "shinjitai" }

local LABELS = {
  traditional = "TRADITIONAL",
  simplified = "SIMPLIFIED",
  shinjitai = "SHINJITAI",
}

local current = "traditional"
local loaded = false
local dictionaries = nil
local warned = false

-- Drawing calls repeat the same labels every frame.  Cache short converted
-- strings, but periodically discard the cache so dynamic values (timers,
-- money, IDs) cannot make it grow for an entire play session.
local cache = { simplified = {}, shinjitai = {} }
local cacheCount = { simplified = 0, shinjitai = 0 }
local CACHE_MAX_ENTRIES = 2048
local CACHE_MAX_BYTES = 128

local function warn(message)
  if warned then return end
  warned = true
  local ok, Logger = pcall(require, "src.core.Logger")
  if ok and Logger and Logger.warn then
    Logger.warn("character variants: %s", message)
  end
end

local function readFile(path)
  if love and love.filesystem and love.filesystem.read then
    local contents = love.filesystem.read(path)
    if contents then return contents end
  end
  local file = io.open(path, "rb")
  if not file then return nil end
  local contents = file:read("*a")
  file:close()
  return contents
end

-- OpenCC text dictionaries are `key<TAB>candidate candidate ...`.  Conversion
-- uses the first candidate.  For the Japanese table, `reverse=true` builds
-- kyujitai -> Shinjitai from the upstream Shinjitai -> kyujitai source table,
-- which is how OpenCC generates JPShinjitaiCharactersRev for t2jp.json.
local function parseDictionary(path, reverse)
  local raw = readFile(path)
  if not raw then return nil, 0 end
  local map = {}
  local maxKeyBytes = 0
  for line in (raw .. "\n"):gmatch("([^\r\n]*)\r?\n") do
    if line ~= "" and line:sub(1, 1) ~= "#" then
      local key, values = line:match("^([^\t]+)\t(.+)$")
      if key and values then
        if reverse then
          for value in values:gmatch("%S+") do
            map[value] = key
            if #value > maxKeyBytes then maxKeyBytes = #value end
          end
        else
          local value = values:match("^(%S+)")
          if value then
            map[key] = value
            if #key > maxKeyBytes then maxKeyBytes = #key end
          end
        end
      end
    end
  end
  return map, maxKeyBytes
end

local function ensureLoaded()
  if loaded then return dictionaries ~= nil end
  loaded = true

  local compatibility = parseDictionary(
    "assets/opencc/CJK_Compatibility_Ideographs.txt")
  local tsChars = parseDictionary("assets/opencc/TSCharacters.txt")
  local tsPhrases, maxPhraseBytes = parseDictionary(
    "assets/opencc/TSPhrases.txt")
  local jpReverse = parseDictionary(
    "assets/opencc/JPShinjitaiCharacters.txt", true)

  if not compatibility or not tsChars or not tsPhrases or not jpReverse then
    dictionaries = nil
    warn("could not load one or more assets/opencc dictionaries; leaving text unchanged")
    return false
  end

  dictionaries = {
    compatibility = compatibility,
    tsChars = tsChars,
    tsPhrases = tsPhrases,
    tsMaxPhraseBytes = maxPhraseBytes,
    jpReverse = jpReverse,
  }
  return true
end

-- Last byte of the UTF-8 character beginning at i.  Invalid input falls back
-- to one byte, matching Font.split's defensive behaviour.
local function charEnd(text, i)
  local b = text:byte(i)
  if not b or b < 0x80 then return i end
  local count
  if b >= 0xF0 and b <= 0xF7 then count = 3
  elseif b >= 0xE0 then count = 2
  elseif b >= 0xC0 then count = 1
  else return i end
  local last = i
  for k = 1, count do
    local c = text:byte(i + k)
    if not c or c < 0x80 or c > 0xBF then return i end
    last = i + k
  end
  return last
end

local function convertChars(text, map)
  local out = {}
  local i = 1
  while i <= #text do
    local last = charEnd(text, i)
    local ch = text:sub(i, last)
    out[#out + 1] = map[ch] or ch
    i = last + 1
  end
  return table.concat(out)
end

-- OpenCC's t2s chain gives phrase matches priority over the character table.
-- Longest-prefix matching reproduces the important distinction in cases such
-- as 乾隆 -> 乾隆 while bare 乾 -> 干, then falls through character by
-- character when no phrase starts at the current position.
local function convertSimplified(text, data)
  text = convertChars(text, data.compatibility)
  local out = {}
  local i = 1
  while i <= #text do
    local hit, hitBytes
    local remaining = #text - i + 1
    local maxBytes = math.min(data.tsMaxPhraseBytes, remaining)
    for bytes = maxBytes, 1, -1 do
      local candidate = data.tsPhrases[text:sub(i, i + bytes - 1)]
      if candidate then
        hit, hitBytes = candidate, bytes
        break
      end
    end
    if hit then
      out[#out + 1] = hit
      i = i + hitBytes
    else
      local last = charEnd(text, i)
      local ch = text:sub(i, last)
      out[#out + 1] = data.tsChars[ch] or ch
      i = last + 1
    end
  end
  return table.concat(out)
end

local function convertShinjitai(text, data)
  text = convertChars(text, data.compatibility)
  return convertChars(text, data.jpReverse)
end

local function validMode(mode)
  for _, candidate in ipairs(CharacterVariant.MODES) do
    if mode == candidate then return mode end
  end
  return "traditional"
end

function CharacterVariant.applyOptions(opts)
  current = validMode(opts and opts.hanVariant)
end

function CharacterVariant.current()
  return current
end

function CharacterVariant.label(mode)
  return LABELS[validMode(mode)]
end

function CharacterVariant.cycle(mode, direction)
  mode = validMode(mode)
  local index = 1
  for i, candidate in ipairs(CharacterVariant.MODES) do
    if candidate == mode then index = i break end
  end
  local delta = direction and direction < 0 and -1 or 1
  index = ((index - 1 + delta) % #CharacterVariant.MODES) + 1
  return CharacterVariant.MODES[index]
end

function CharacterVariant.convert(text, mode)
  if type(text) ~= "string" or text == "" then return text end
  mode = validMode(mode or current)
  if mode == "traditional" then return text end
  if not ensureLoaded() then return text end

  local modeCache = cache[mode]
  if #text <= CACHE_MAX_BYTES then
    local found = modeCache[text]
    if found ~= nil then return found end
  end

  local result
  if mode == "simplified" then
    result = convertSimplified(text, dictionaries)
  else
    result = convertShinjitai(text, dictionaries)
  end

  if #text <= CACHE_MAX_BYTES then
    if cacheCount[mode] >= CACHE_MAX_ENTRIES then
      cache[mode] = {}
      cacheCount[mode] = 0
      modeCache = cache[mode]
    end
    modeCache[text] = result
    cacheCount[mode] = cacheCount[mode] + 1
  end
  return result
end

-- Test/dev helper.  Runtime callers should use applyOptions instead.
function CharacterVariant.reset()
  current = "traditional"
  cache = { simplified = {}, shinjitai = {} }
  cacheCount = { simplified = 0, shinjitai = 0 }
end

return CharacterVariant
