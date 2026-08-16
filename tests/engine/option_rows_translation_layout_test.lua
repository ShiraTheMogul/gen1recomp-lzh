-- Options rows must survive a CJK translation inside the original 32px boxes.
-- Translation is resolved at draw time, Han is drawn at a compact 12px, and
-- label/value pairs share one centred row when they fit.
-- ROM-free/headless.
--   texlua tests/engine/option_rows_translation_layout_test.lua

package.path = "./?.lua;./?/init.lua;" .. package.path

local T = require("tests.modkit")
local eq, check = T.eq, T.check
local Font = require("src.render.Font")
local Theme = require("src.ui.Theme")
local Strings = require("src.core.Strings")
local OptionRows = require("src.ui.OptionRows")

local saved = {
  width = Font.width, widthSized = Font.widthSized,
  draw = Font.draw, drawSized = Font.drawSized,
  drawCode = Font.drawCode, drawBox = Font.drawBox,
  ttfActive = Font.ttfActive, encode = Font.encode,
}

local translations = {
  ["TEXT SPEED"] = "文速", ["MEDIUM"] = "中",
  ["HAN FORM"] = "字形", ["TRADITIONAL"] = "繁體",
  ["BATTLE ANIMATION"] = "戰動畫", ["ON"] = "開",
  ["BATTLE STYLE"] = "戰制", ["SHIFT"] = "易",
  ["CANCEL"] = "罷",
}
Strings.load({ strings = translations })

local draws, codes = {}, {}
local function hanCount(text)
  local n = 0
  for _ in tostring(text):gmatch("[\228-\233][\128-\191][\128-\191]") do n = n + 1 end
  return n
end

Font.ttfActive = function() return true end
Font.encode = function(text)
  if translations[text] or hanCount(text) > 0 then return { Font.TTF_BASE + 1 } end
  return { 0x80 }
end
Font.width = function(text) return #tostring(text) * 8 end
Font.widthSized = function(text, size)
  local count = hanCount(text)
  return (count > 0 and count or #tostring(text)) * size
end
Font.draw = function(text, x, y)
  draws[#draws + 1] = { text = text, x = x, y = y, size = 8 }
  return Font.width(text)
end
Font.drawSized = function(text, x, y, size)
  draws[#draws + 1] = { text = text, x = x, y = y, size = size }
  return Font.widthSized(text, size)
end
Font.drawCode = function(code, x, y)
  codes[#codes + 1] = { code = code, x = x, y = y }
end
Font.drawBox = function() end

local rows = {
  { label = "TEXT SPEED", value = function() return "MEDIUM" end },
  { label = "HAN FORM", value = function() return "TRADITIONAL" end },
  { label = "BATTLE ANIMATION", value = function() return "ON" end },
  { label = "BATTLE STYLE", value = function() return "SHIFT" end },
}

OptionRows.draw({}, rows, 2, 0, "CANCEL", 5)

local byText = {}
for _, d in ipairs(draws) do byText[d.text] = d end

-- This is the regression from the screenshot: the source-language strings
-- may enter OptionRows, but the visible strings must be translated here.
check(byText["TEXT SPEED"] == nil and byText["MEDIUM"] == nil,
  "source TEXT SPEED row is not drawn")
check(byText["BATTLE ANIMATION"] == nil and byText["ON"] == nil,
  "source BATTLE ANIMATION row is not drawn")
check(byText["BATTLE STYLE"] == nil and byText["SHIFT"] == nil,
  "source BATTLE STYLE row is not drawn")

eq(byText["文速"].x, 16, "translated TEXT SPEED label stays left")
eq(byText["中"].x, 124, "translated TEXT SPEED value is right-aligned")
eq(byText["文速"].y, 10, "first translated row is vertically centred")
eq(byText["中"].y, 10, "first translated value shares the row")

eq(byText["字形"].x, 16, "HAN FORM label stays left")
eq(byText["繁體"].x, 112, "HAN FORM value is right-aligned")
eq(byText["字形"].y, 42, "second row is centred")

eq(byText["戰動畫"].x, 16, "battle-animation label translated")
eq(byText["開"].x, 124, "battle-animation value translated and right-aligned")
eq(byText["戰動畫"].y, 74, "third row stays clear of both borders")

eq(byText["戰制"].x, 16, "battle-style label translated")
eq(byText["易"].x, 124, "battle-style value translated and right-aligned")
eq(byText["戰制"].y, 106, "fourth row stays clear of both borders")

eq(byText["罷"].y, 130, "translated CANCEL footer fits fully on-screen")

for _, text in ipairs({ "文速", "中", "字形", "繁體", "戰動畫", "開", "戰制", "易", "罷" }) do
  eq(byText[text].size, 12, text .. " uses compact options-menu TTF size")
end

local cursor
for _, d in ipairs(codes) do
  if d.code == Theme.cursor then cursor = d break end
end
check(cursor ~= nil, "selected row draws its cursor")
eq(cursor.y, 44, "8px cursor is centred beside the 12px Han row")

Font.width, Font.widthSized = saved.width, saved.widthSized
Font.draw, Font.drawSized = saved.draw, saved.drawSized
Font.drawCode, Font.drawBox = saved.drawCode, saved.drawBox
Font.ttfActive, Font.encode = saved.ttfActive, saved.encode
Strings.load({ strings = {} })

T.finish("option rows translation layout")
