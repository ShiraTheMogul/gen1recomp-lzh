-- The four-box options viewport, extracted from OptionsMenu so the mod
-- manager's per-mod options auto-UI renders schemas in the same idiom.
-- Rows are descriptors:
--   { id, label, value = fn(game) -> string,
--     step = fn(game, dir) -> changed, activate = fn(game) }
-- step handles Left/Right/A cyclers; activate is the A-press action for
-- rows that open something instead (MODS, CANCEL stays the caller's).

local Font = require("src.render.Font")
local Theme = require("src.ui.Theme")
local Strings = require("src.core.Strings")

local OptionRows = {}

OptionRows.VISIBLE = 4 -- option boxes on screen at once (4 tiles each)

-- keep the cursor's box inside the viewport; the fixed bottom row shows
-- the tail of the list
function OptionRows.clampScroll(index, scroll, total, bottomRow)
  if bottomRow and index >= bottomRow then
    return math.max(0, total - OptionRows.VISIBLE)
  elseif index <= scroll then
    return index - 1
  elseif index > scroll + OptionRows.VISIBLE then
    return index - OptionRows.VISIBLE
  end
  return scroll
end

local LABEL_X = 16
local VALUE_RIGHT = 136 -- leave a gutter before the right border
local COLUMN_GAP = 8
local BOX_HEIGHT = 32
local TTF_ROW_SIZE = 12

local function containsTTFGlyph(text)
  if not Font.ttfActive() or not text or text == "" then return false end
  for _, code in ipairs(Font.encode(text)) do
    if code >= Font.TTF_BASE then return true end
  end
  return false
end

local function drawMeasured(text, x, y, size)
  if size then return Font.drawSized(text, x, y, size) end
  return Font.draw(text, x, y)
end

local function measure(text, size)
  if size then return Font.widthSized(text, size) end
  return Font.width(text)
end

-- The TTF's configured cell is 16px, but an options box is only 32px tall.
-- Draw Han at 12px here; cartridge-tile text remains genuinely 8px high.
-- Keeping layout height separate from Font.cellHeight is what prevents a
-- two-line ASCII fallback from being treated as 16+16px and crossing borders.
local function textMetrics(text)
  if containsTTFGlyph(text) then return TTF_ROW_SIZE, TTF_ROW_SIZE end
  return 8, nil
end

local function centeredY(top, size)
  return top + math.floor((BOX_HEIGHT - size) / 2)
end

function OptionRows.draw(game, rows, index, scroll, bottomLabel, bottomRow)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", 0, 0, 160, 144)

  for slot = 1, OptionRows.VISIBLE do
    local i = scroll + slot
    local row = rows[i]
    if not row then break end

    local top = (slot - 1) * BOX_HEIGHT
    -- Resolve translations at draw time.  Some options screens are built
    -- before the translation catalog is loaded, and mod-added rows may also
    -- carry source-language labels.  Re-looking them up here is idempotent
    -- for already translated strings and guarantees the visible row uses the
    -- live catalog.
    local label = type(row.label) == "string" and Strings(row.label) or row.label
    local rawValue = row.value and row.value(game) or ""
    local value = type(rawValue) == "string" and Strings(rawValue) or rawValue
    label = label or ""
    value = value or ""
    local labelHeight, labelSize = textMetrics(label)
    local valueHeight, valueSize = textMetrics(value)
    local labelWidth = measure(label, labelSize)
    local valueWidth = measure(value, valueSize)
    local valueX = math.max(LABEL_X, VALUE_RIGHT - valueWidth)
    local inline = value ~= ""
      and labelWidth + COLUMN_GAP + valueWidth <= VALUE_RIGHT - LABEL_X

    local labelY, valueY
    if inline then
      local lineHeight = math.max(labelHeight, valueHeight)
      local y = centeredY(top, lineHeight)
      labelY = y + math.floor((lineHeight - labelHeight) / 2)
      valueY = y + math.floor((lineHeight - valueHeight) / 2)
    else
      local gap = 2
      local total = labelHeight + gap + valueHeight
      local startY = top + math.floor((BOX_HEIGHT - total) / 2)
      labelY = startY
      valueY = startY + labelHeight + gap
    end

    Font.drawBox(0, (slot - 1) * 4, 20, 4)
    love.graphics.setColor(0, 0, 0, 1)
    drawMeasured(label, LABEL_X, labelY, labelSize)
    if value ~= "" then
      drawMeasured(value, valueX, valueY, valueSize)
    end

    if i == index then
      local cursorLineY = inline and math.min(labelY, valueY) or labelY
      local cursorHeight = inline and math.max(labelHeight, valueHeight) or labelHeight
      local cursorY = cursorLineY + math.floor((cursorHeight - 8) / 2)
      Font.drawCode(Theme.cursor, 8, cursorY)
    end
  end

  if scroll + OptionRows.VISIBLE < #rows then
    Font.drawCode(Theme.moreArrow, 144, 128)
  end

  if bottomLabel then
    love.graphics.setColor(0, 0, 0, 1)
    local visibleBottom = type(bottomLabel) == "string" and Strings(bottomLabel) or bottomLabel
    visibleBottom = visibleBottom or ""
    local height, size = textMetrics(visibleBottom)
    local bottomY = math.max(128, 144 - height - 2)
    drawMeasured(visibleBottom, LABEL_X, bottomY, size)
    if bottomRow and index == bottomRow then
      local cursorY = bottomY + math.floor((height - 8) / 2)
      Font.drawCode(Theme.cursor, 8, cursorY)
    end
  end

  love.graphics.setColor(1, 1, 1, 1)
end

return OptionRows
