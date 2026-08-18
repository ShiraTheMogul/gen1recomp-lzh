-- Compact traditional numeral formatter for localized UI.
--
-- The Literary Chinese localization uses tally-like low-complexity digits in
-- dense HUD contexts: 亖 for 4 and a private-use five-bar glyph (U+E000,
-- drawn by Font.lua) for 5.  20/30/40 use the traditional 廾/卅/卌 forms.
-- Keeping the convention here means every caller gets the same notation and
-- a future glyph change is one edit, not a hunt through dozens of screens.

local Font = require("src.render.Font")

local HanNumber = {}

local FIVE = Font.PRIVATE_FIVE
local DIGIT = {
  [0] = "〇", [1] = "一", [2] = "二", [3] = "三", [4] = "亖",
  [5] = FIVE, [6] = "六", [7] = "七", [8] = "八", [9] = "九",
}

local TENS = { [2] = "廾", [3] = "卅", [4] = "卌" }
local SMALL_ADVANCES = { ["："] = 6, ["，"] = 6 }

function HanNumber.enabled()
  return Font.numberStyle() == "han"
end

local function below100(n)
  if n < 10 then return DIGIT[n] end
  local tens = math.floor(n / 10)
  local ones = n % 10
  local out
  if tens == 1 then
    out = "十"
  elseif TENS[tens] then
    out = TENS[tens]
  else
    out = DIGIT[tens] .. "十"
  end
  if ones ~= 0 then out = out .. DIGIT[ones] end
  return out
end

local function below10000(n)
  if n < 100 then return below100(n) end
  local out = ""
  local thousands = math.floor(n / 1000)
  local hundreds = math.floor(n / 100) % 10
  local rest = n % 100

  if thousands > 0 then
    out = out .. (thousands == 1 and "" or DIGIT[thousands]) .. "千"
  end
  if hundreds > 0 then
    out = out .. (hundreds == 1 and "" or DIGIT[hundreds]) .. "百"
  elseif thousands > 0 and rest > 0 then
    out = out .. "〇"
  end

  if rest > 0 then
    if (thousands > 0 or hundreds > 0) and rest < 10
        and out:sub(-#"〇") ~= "〇" then
      out = out .. "〇"
    end
    out = out .. below100(rest)
  end
  return out
end

local function positive(n)
  if n < 10000 then return below10000(n) end
  if n < 100000000 then
    local hi = math.floor(n / 10000)
    local lo = n % 10000
    local out = (hi == 1 and "" or below10000(hi)) .. "萬"
    if lo > 0 then
      if lo < 1000 then out = out .. "〇" end
      out = out .. below10000(lo)
    end
    return out
  end
  local hi = math.floor(n / 100000000)
  local lo = n % 100000000
  local out = (hi == 1 and "" or positive(hi)) .. "億"
  if lo > 0 then
    if lo < 10000000 then out = out .. "〇" end
    out = out .. positive(lo)
  end
  return out
end

function HanNumber.format(value)
  local n = math.floor(tonumber(value) or 0)
  if not HanNumber.enabled() then return tostring(n) end
  if n == 0 then return DIGIT[0] end
  if n < 0 then return "負" .. positive(-n) end
  return positive(n)
end

-- Dialogue uses the full-size Wenjin glyphs, where the deliberately geometric
-- HUD tally for five reads as a stack of bars.  Keep compact 亖/PUA-five in
-- dense numeric UI, but normalize them to ordinary 四/五 when a quantity is
-- inserted into prose such as experience and prize-money messages.
function HanNumber.prose(value)
  local out = HanNumber.format(value)
  if not HanNumber.enabled() then return out end
  out = out:gsub(Font.PRIVATE_FIVE, "五")
  out = out:gsub("亖", "四")
  return out
end

-- Identifier formatting is deliberately distinct from arithmetic formatting.
-- A Trainer ID or Pokédex number is a sequence of decimal digits, not a
-- quantity to be read as e.g. 三萬九千一百六.  Preserve each place as its
-- own glyph (and optional leading zeroes): 39106 -> 三九一〇六.
function HanNumber.digits(value, width)
  local n = math.max(0, math.floor(tonumber(value) or 0))
  local ascii = tostring(n)
  width = math.max(0, math.floor(tonumber(width) or 0))
  if width > #ascii then ascii = string.rep("0", width - #ascii) .. ascii end
  if not HanNumber.enabled() then return ascii end
  local out = {}
  for i = 1, #ascii do
    local d = tonumber(ascii:sub(i, i)) or 0
    out[#out + 1] = DIGIT[d]
  end
  return table.concat(out)
end

-- Ratios use the compact Classical fraction order: denominator 之 numerator.
-- Thus current/max 19/20 is 廾之十九.  This is both historically grounded
-- and much clearer at small sizes than a slash running between two Han cells.
function HanNumber.pair(current, total)
  if not HanNumber.enabled() then
    return tostring(math.floor(tonumber(current) or 0)) .. "/"
      .. tostring(math.floor(tonumber(total) or 0))
  end
  return HanNumber.format(total) .. "之" .. HanNumber.format(current)
end

function HanNumber.clock(hours, minutes)
  if not HanNumber.enabled() then
    return ("%d:%02d"):format(hours, minutes)
  end
  return HanNumber.format(hours) .. "：" .. HanNumber.format(minutes)
end

function HanNumber.size()
  return HanNumber.enabled() and Font.numberSize() or Font.cellHeight()
end

function HanNumber.widthText(text, size)
  if not HanNumber.enabled() then return Font.width(text) end
  return Font.widthSized(text, size or Font.numberSize(), SMALL_ADVANCES)
end

function HanNumber.drawText(text, x, y, size)
  if not HanNumber.enabled() then return Font.draw(text, x, y) end
  return Font.drawSized(text, x, y, size or Font.numberSize(), SMALL_ADVANCES)
end

function HanNumber.draw(value, x, y, size)
  return HanNumber.drawText(HanNumber.format(value), x, y, size)
end

function HanNumber.drawRightText(text, right, y, size)
  local w = HanNumber.widthText(text, size)
  HanNumber.drawText(text, right - w, y, size)
  return w
end

function HanNumber.drawRight(value, right, y, size)
  return HanNumber.drawRightText(HanNumber.format(value), right, y, size)
end

return HanNumber
