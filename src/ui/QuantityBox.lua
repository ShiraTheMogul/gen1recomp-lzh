-- The "how many?" selector (DisplayChooseQuantityMenu, home/list_menu.asm):
-- Up/Down step by 1 with 1..max roll-over, A confirms, B cancels.
-- Shows a running price when opts.unitPrice is set.

local Font = require("src.render.Font")
local Strings = require("src.core.Strings")
local HanNumber = require("src.render.HanNumber")

local QuantityBox = {}
QuantityBox.__index = QuantityBox
QuantityBox.isOpaque = false

function QuantityBox.new(game, opts)
  local self = setmetatable({}, QuantityBox)
  self.game = game
  self.max = math.max(1, opts.max or 99)
  self.qty = math.min(opts.start or 1, self.max)
  self.unitPrice = opts.unitPrice
  self.onDone = opts.onDone -- onDone(qty | nil on cancel)
  return self
end

local function wrap(v, max)
  if v < 1 then return max end
  if v > max then return 1 end
  return v
end

function QuantityBox:update(dt)
  local input = self.game.input
  if input:wasPressed("up") then
    self.qty = wrap(self.qty + 1, self.max)
  elseif input:wasPressed("down") then
    self.qty = wrap(self.qty - 1, self.max)
  elseif input:wasPressed("a") then
    self.game.stack:pop()
    if self.onDone then self.onDone(self.qty) end
  elseif input:wasPressed("b") then
    self.game.stack:pop()
    if self.onDone then self.onDone(nil) end
  end
end

function QuantityBox:draw()
  -- DisplayChooseQuantityMenu (home/list_menu.asm) used fixed 3- and
  -- 11-tile interiors.  Han quantity/cost strings are wider, especially
  -- once place-value markers appear, so retain the right edge and grow the
  -- frame leftward from a sensible vanilla-derived minimum.
  local ty = 9
  local size = 10
  local s = "×" .. HanNumber.digits(self.qty, 2) -- preserve the 2-place selector
  if self.unitPrice then
    s = s .. " " .. HanNumber.format(self.qty * self.unitPrice)
      .. Strings("CURRENCY_UNIT")
  end

  local textWidth = Font.widthSized(s, size)
  local minTw = self.unitPrice and 13 or 7
  local tw = math.max(minTw, math.ceil((textWidth + 8) / 8) + 2)
  tw = math.min(20, tw)
  local tx = 20 - tw

  Font.drawBox(tx, ty, tw, 3)
  love.graphics.setColor(0, 0, 0, 1)
  Font.drawSized(s, (tx + 1) * 8, (ty + 1) * 8 - 1, size)
  love.graphics.setColor(1, 1, 1, 1)
end

return QuantityBox
