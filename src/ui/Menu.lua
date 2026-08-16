-- Generic bordered list menu with the blinking ▶ cursor.
-- items: { { label=..., onSelect=function }, ... }
-- Pops itself on B (unless cancelable=false); also on START only when
-- opts.startCloses is set -- pokered's wMenuWatchedKeys mask varies per
-- menu and only the start menu's adds PAD_START.

local Font = require("src.render.Font")
local Theme = require("src.ui.Theme")

local Menu = {}
Menu.__index = Menu

function Menu.new(game, items, opts)
  local self = setmetatable({}, Menu)
  opts = opts or {}
  self.game = game
  self.items = items
  self.index = 1
  self.tx = opts.tx or 10
  self.ty = opts.ty or 0
  self.tw = opts.tw or 10
  -- Large-font localizations use the same 12px choice-label face as the
  -- YES/NO box. Choice rows remain 16px apart; only truly over-wide labels
  -- fall back to 10px.
  self.largeFont = Font.cellHeight() > 8
  self.labelSize = opts.labelSize or (self.largeFont and 12 or Font.cellHeight())
  -- Grow the box from measured pixels, not character count.
  do
    local function widestAt(size)
      local widest = 0
      for _, it in ipairs(items) do
        if it.label then
          local w = self.largeFont and Font.widthSized(it.label, size)
            or Font.width(it.label)
          if w > widest then widest = w end
        end
      end
      return widest
    end

    local maxTw = math.min(20, opts.maxTw or 20)
    local widestPx = widestAt(self.labelSize)
    if self.largeFont and not opts.labelSize
       and math.ceil(widestPx / 8) + 3 > maxTw then
      self.labelSize = 10
      widestPx = widestAt(self.labelSize)
    end

    -- Menu geometry remains tile-based; convert measured pixels back to
    -- whole tiles and cap the frame at the physical screen width.
    local needed = math.min(maxTw, math.ceil(widestPx / 8) + 3)
    if needed > self.tw then self.tw = needed end
    if self.tw > maxTw then self.tw = maxTw end
    if self.tx + self.tw > 20 then self.tx = math.max(0, 20 - self.tw) end
  end
  self.rowStep = opts.rowStep or 2
  -- maxVisible: cap the box to this many rows and scroll the rest instead
  -- of growing past it (e.g. the start menu, whose row count varies with
  -- save state and mod hooks); nil/unset keeps every caller's old
  -- behavior of sizing the box to fit all items.
  self.maxVisible = opts.maxVisible
  self.scroll = 0
  local visible = (self.maxVisible and math.min(self.maxVisible, #items))
    or #items
  local contentTh = visible * self.rowStep + 2
  -- Cartridge callers often pass a box height chosen for 8px labels.  In the
  -- Han UI, size the choice window to its actual rows instead of preserving
  -- surplus blank space or clipping a 12px label against an old border.
  self.th = self.largeFont and contentTh or (opts.th or contentTh)
  if self.ty + self.th > 18 then self.ty = math.max(0, 18 - self.th) end
  self.cancelable = opts.cancelable ~= false
  -- Whether START closes the menu.  In pokered a menu responds only to the
  -- keys in its wMenuWatchedKeys mask; the common PAD_A | PAD_B (and the
  -- list menu's PAD_A | PAD_B | PAD_SELECT) masks leave START unwatched, so
  -- only menus whose real mask includes PAD_START -- the start menu
  -- (engine/menus/draw_start_menu.asm) -- opt in here.
  self.startCloses = opts.startCloses or false
  -- screen-edge anchor for this menu (see Menu:draw); nil keeps it in the
  -- classic centred letterbox
  self.anchor = opts.anchor
  self.onCancel = opts.onCancel
  -- BIT_NO_MENU_BUTTON_SOUND (wMiscFlags): the PC session runs its
  -- menus silent (home/window.asm HandleMenuInput_)
  self.noSound = opts.noSound or false
  self:clampScroll()
  return self
end

-- keeps self.index inside the visible [scroll+1, scroll+maxVisible] window;
-- callers that move self.index directly (e.g. restoring a saved cursor
-- position) should call this afterwards to scroll it into view
function Menu:clampScroll()
  if not (self.maxVisible and #self.items > self.maxVisible) then
    self.scroll = 0
    return
  end
  if self.index - self.scroll > self.maxVisible then
    self.scroll = self.index - self.maxVisible
  elseif self.index - self.scroll < 1 then
    self.scroll = self.index - 1
  end
end

function Menu:update(dt)
  local input = self.game.input
  if input:wasPressed("up") then
    self.index = self.index > 1 and self.index - 1 or #self.items
  elseif input:wasPressed("down") then
    self.index = self.index < #self.items and self.index + 1 or 1
  elseif input:wasPressed("a") then
    -- HandleMenuInput_ (home/window.asm): SFX_PRESS_AB on every A press
    if not self.noSound then
      require("src.core.Sound").play(self.game.data, "Press_AB")
    end
    local item = self.items[self.index]
    -- keepOpen entries run without closing the menu (e.g. the
    -- Pokédex CRY option keeps the side menu up)
    if not item.keepOpen then self.game.stack:pop() end
    if item.onSelect then item.onSelect() end
  elseif self.cancelable and (input:wasPressed("b")
      or (self.startCloses and input:wasPressed("start"))) then
    -- HandleMenuInput_ returns for any watched key, but only replays
    -- SFX_PRESS_AB for the PAD_A | PAD_B branch -- so B beeps and START
    -- (when watched, e.g. the start menu) closes silently.
    if input:wasPressed("b") and not self.noSound then
      require("src.core.Sound").play(self.game.data, "Press_AB")
    end
    self.game.stack:pop()
    if self.onCancel then self.onCancel() end
  end
  self:clampScroll()
end

function Menu:draw()
  -- opts.anchor opts a menu out of the centred letterbox and onto a screen
  -- edge (the START menu asks for "topright").  Only menus that ask for it
  -- move; every other menu is placed exactly as before.
  local r = self.anchor and self.game and self.game.renderer
  if r and r.setUIAnchor then
    r:setUIAnchor(self.tx * 8, self.ty * 8,
                  self.tw * 8, self.th * 8, self.anchor)
  end
  Font.drawBox(self.tx, self.ty, self.tw, self.th)
  love.graphics.setColor(0, 0, 0, 1)
  local visible = (self.maxVisible and math.min(self.maxVisible, #self.items))
    or #self.items
  -- Han choices follow ChoiceBox's geometry: first item one tile below
  -- the top border, then every two tile rows. The cartridge bottom-anchor
  -- leaves a spare row above translated choices and makes them float down.
  for row = 1, visible do
    local item = self.items[self.scroll + row]
    if not item then break end
    if self.largeFont then
      local y = (self.ty + 1 + (row - 1) * self.rowStep) * 8
      Font.drawSized(item.label, (self.tx + 2) * 8, y + 3, self.labelSize)
    else
      local y = (self.ty + self.th - 2 - (visible - row) * self.rowStep) * 8
      Font.draw(item.label, (self.tx + 2) * 8, y)
    end
  end
  local cursorRow = self.index - self.scroll
  local cursorY
  if self.largeFont then
    cursorY = (self.ty + 1 + (cursorRow - 1) * self.rowStep) * 8 + 4
  else
    cursorY = (self.ty + self.th - 2 - (visible - cursorRow) * self.rowStep) * 8
  end
  Font.drawCode(Theme.cursor, (self.tx + 1) * 8, cursorY)
  -- moreArrow ($EE): the same "more below" glyph OptionRows/ManagerState
  -- use, sat on the bottom border like TextBox's page-advance cursor.  It
  -- has to be the border row, not ty + th - 2: that is the last interior
  -- row, which the last choice now occupies, and Menu.new widens the box to
  -- widest + 3 so tx + tw - 2 is exactly that label's final glyph (#564).
  if self.maxVisible and self.scroll + self.maxVisible < #self.items then
    Font.drawCode(Theme.moreArrow, (self.tx + self.tw - 2) * 8,
      (self.ty + self.th - 1) * 8)
  end
  love.graphics.setColor(1, 1, 1, 1)
end

return Menu
