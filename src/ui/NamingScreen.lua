-- Gen 1 naming screen, adapted for the Literary Chinese translation.
--
-- The cartridge's UPPER/lower-case pages become two views of one Cangjie 5
-- keyboard:
--   * default page: 倉頡字根 (Q=手, W=田, E=水 ...)
--   * alternate page: the same physical QWERTY positions labelled A-Z
--
-- A second, EXPLICIT input-mode toggle separates the two control models:
--   * default 遊戲兒/Game Boy mode: every physical keyboard key keeps the
--     recomp's normal GB bindings (Z/Enter/Space=A, X/Backspace=B, etc.)
--   * 鍵盤 mode: ONLY A-Z (plus optional candidate shortcuts) are captured
--     as direct Cangjie typing.  Ordinary navigation/A/B/START/SELECT keys
--     continue through the engine's normal binding path.
--
-- Both root/ABC pages enter the same internal ASCII Cangjie code.  There is
-- no lower-case name-entry page.  Exact single-character candidates come
-- from the generated Rime-derived table in data/input/cangjie5.lua.
--
-- Game Boy controls (always the default):
--   D-pad / arrows  move around keys/candidates
--   A               add root / choose candidate / activate bottom item
--   B               erase one Cangjie key, otherwise erase one name glyph
--   SELECT          switch 字根 <-> ABC display
--   START           focus candidates while composing; otherwise finish
--
-- Direct keyboard Cangjie is deliberately opt-in from the middle bottom item.
-- It necessarily steals alphabetic keys (including Z/X) while active, but it
-- does NOT reimplement the engine's control map: Enter/Backspace/arrows/etc.
-- still travel through Game -> Input normally.

local Cangjie = require("src.input.Cangjie")
local Font = require("src.render.Font")
local Sound = require("src.core.Sound")
local Strings = require("src.core.Strings")

local NamingScreen = {}
NamingScreen.__index = NamingScreen
NamingScreen.isOpaque = true

local KEY_Y = { 72, 88, 104 }
local KEY_X = {
  -- Ten QWERTY keys occupy the complete 160px row.
  function(col) return (col - 1) * 16 end,
  -- Home and bottom rows are indented to mirror a physical keyboard.
  function(col) return 8 + (col - 1) * 16 end,
  function(col) return 24 + (col - 1) * 16 end,
}

local CANDIDATE_Y = 56
local CANDIDATE_X0 = 8
local META_Y = 128
-- Three bottom actions: root/ABC view, input-device toggle, confirm.
local META_X = { 16, 64, 136 }
local META_CENTER_X = { 32, 88, 144 }

-- IMPORTANT: this is a naming-screen-only cursor correction.  Font.draw's
-- 16px Wenjin glyphs deliberately use the engine's legacy 8px tile baseline;
-- several existing translated HUD/status layouts already compensate for that
-- global convention.  Do NOT "fix" Font.lua here.  The visible Han cell
-- begins about seven pixels above the draw anchor, so the focus rectangle is
-- raised locally to surround what is actually painted.
local HAN_FOCUS_TOP = -8
local HAN_FOCUS_H = 18
local TILE_FOCUS_TOP = -1
local TILE_FOCUS_H = 10

-- SGB: generic whole-screen palette (SET_PAL_GENERIC)
function NamingScreen:sgbPalettes(game)
  return require("src.render.PaletteFX").wholeNamed(game.data, "MEWMON")
end

function NamingScreen.new(game, opts)
  opts = opts or {}
  local self = setmetatable({}, NamingScreen)
  self.game = game
  self.title = opts.title or Strings("YOUR NAME?")
  self.presets = opts.presets
  self.maxLen = opts.maxLen or 7
  self.default = opts.default
  self.onDone = opts.onDone

  -- One array entry is one displayed name glyph, regardless of UTF-8 byte
  -- length.  That is exactly what we want for Han characters.
  self.glyphs = {}

  self.ime = Cangjie.new()
  self.latin = false -- Han/component page is ALWAYS the initial page.
  self.keyboardTyping = false -- Game Boy controls are ALWAYS the initial mode.

  -- row 1..3 = QWERTY rows, row 4 = view/input/confirm actions.
  self.row, self.col = 1, 1
  self.candidateFocus = false
  self.candidateCol = 1
  return self
end

function NamingScreen:enter()
  if self.presets and #self.presets > 0 then
    local Menu = require("src.ui.Menu")
    local items = { { label = Strings("NEW NAME") } }
    for _, preset in ipairs(self.presets) do
      table.insert(items, {
        label = preset,
        onSelect = function()
          self.game.stack:pop()
          if self.onDone then self.onDone(preset) end
        end,
      })
    end
    self.game.stack:push(Menu.new(self.game, items, {
      tx = 4, ty = 0, tw = 12, th = #items * 2 + 2, cancelable = false,
    }))
  end
end

function NamingScreen:confirm()
  local name = table.concat(self.glyphs)
  if name == "" then
    -- Preserve the original port's empty-name contract (#833): nickname
    -- callers interpret "" as cancel/no nickname, while player/rival naming
    -- can still fall back to the first preset and Name Rater to opts.default.
    name = (self.presets and self.presets[1]) or self.default or ""
  end
  Sound.play(self.game.data, "Press_AB")
  self.game.stack:pop()
  if self.onDone then self.onDone(name) end
end

function NamingScreen:toggleInterface()
  self.latin = not self.latin
end

function NamingScreen:toggleTypingMode()
  self.keyboardTyping = not self.keyboardTyping
end

function NamingScreen:interfaceToggleLabel()
  return self.latin and "字根" or "ABC"
end

-- The button names the mode it will SWITCH TO, just like ABC/字根 does.
-- 鍵盤 is the physical PC keyboard; 遊戲兒 is Classical Chinese Wikipedia's
-- compact rendering of Game Boy, and keeps this control short enough for the
-- 160px naming screen.
function NamingScreen:typingToggleLabel()
  return self.keyboardTyping and "遊戲兒" or "鍵盤"
end

function NamingScreen:metaLabels()
  return { self:interfaceToggleLabel(), self:typingToggleLabel(), "定" }
end

-- Public mainly for inspection/tests/mod tooling: these are the four visible
-- keyboard rows.  The two interface pages differ only in their labels.
function NamingScreen:grid()
  local out = {}
  for r, codes in ipairs(Cangjie.KEY_ROWS) do
    out[r] = {}
    for _, code in ipairs(codes) do
      out[r][#out[r] + 1] = self.ime:labelFor(code, self.latin)
    end
  end
  out[4] = self:metaLabels()
  return out
end

function NamingScreen:keyCodeAt(row, col)
  local codes = Cangjie.KEY_ROWS[row]
  return codes and codes[col] or nil
end

function NamingScreen:visibleCandidates()
  return self.ime:visibleCandidates()
end

function NamingScreen:resetCandidateCursor()
  self.candidateCol = 1
  if #self:visibleCandidates() == 0 then self.candidateFocus = false end
end

function NamingScreen:pushCode(code)
  if #self.glyphs >= self.maxLen then return false end
  if not self.ime:push(code) then return false end
  self:resetCandidateCursor()
  return true
end

function NamingScreen:backspace()
  if self.ime:backspace() then
    self:resetCandidateCursor()
    return
  end
  table.remove(self.glyphs)
end

function NamingScreen:jumpToEnd()
  self.candidateFocus = false
  self.row, self.col = 4, 3
end

function NamingScreen:commitCandidate(index)
  local candidates = self:visibleCandidates()
  local ch = candidates[index or self.candidateCol]
  if not ch or #self.glyphs >= self.maxLen then return false end

  Sound.play(self.game.data, "Press_AB")
  self.glyphs[#self.glyphs + 1] = ch
  self.ime:reset()
  self.candidateFocus = false
  self.candidateCol = 1

  if #self.glyphs >= self.maxLen then
    self:jumpToEnd()
  else
    self.row = math.min(self.row, 3)
    self.col = math.min(self.col, #Cangjie.KEY_ROWS[self.row])
  end
  return true
end

local function keyCellX(row, col)
  return KEY_X[row](col)
end

function NamingScreen:currentCenterX()
  if self.candidateFocus then
    return CANDIDATE_X0 + (self.candidateCol - 1) * 16 + 8
  end
  if self.row <= 3 then
    return keyCellX(self.row, self.col) + 8
  end
  return META_CENTER_X[self.col]
end

local function nearestCol(count, xForCol, targetX)
  local bestCol, bestDist = 1, math.huge
  for col = 1, count do
    local d = math.abs((xForCol(col) + 8) - targetX)
    if d < bestDist then bestCol, bestDist = col, d end
  end
  return bestCol
end

local function nearestMetaCol(targetX)
  local bestCol, bestDist = 1, math.huge
  for col, x in ipairs(META_CENTER_X) do
    local d = math.abs(x - targetX)
    if d < bestDist then bestCol, bestDist = col, d end
  end
  return bestCol
end

function NamingScreen:moveHorizontal(delta)
  if self.candidateFocus then
    local visible = self:visibleCandidates()
    if #visible == 0 then
      self.candidateFocus = false
      return
    end

    if delta < 0 then
      if self.candidateCol > 1 then
        self.candidateCol = self.candidateCol - 1
      elseif self.ime.page > 1 then
        self.ime:setPage(self.ime.page - 1)
        self.candidateCol = #self:visibleCandidates()
      else
        self.candidateCol = #visible
      end
    else
      if self.candidateCol < #visible then
        self.candidateCol = self.candidateCol + 1
      elseif self.ime.page < self.ime:pageCount() then
        self.ime:setPage(self.ime.page + 1)
        self.candidateCol = 1
      else
        self.candidateCol = 1
      end
    end
    return
  end

  local count = self.row <= 3 and #Cangjie.KEY_ROWS[self.row] or 3
  self.col = ((self.col - 1 + delta) % count) + 1
end

function NamingScreen:moveVertical(delta)
  local x = self:currentCenterX()
  local haveCandidates = #self:visibleCandidates() > 0

  -- Treat the screen as one vertical ring:
  --   candidates -> QWERTY1 -> QWERTY2 -> QWERTY3 -> actions -> candidates
  -- when candidates exist.  This fixes the old asymmetry where the candidate
  -- row could only be reached by climbing upward through the entire keyboard.
  if self.candidateFocus then
    self.candidateFocus = false
    if delta > 0 then
      self.row = 1
      self.col = nearestCol(#Cangjie.KEY_ROWS[1],
        function(c) return keyCellX(1, c) end, x)
    else
      self.row = 4
      self.col = nearestMetaCol(x)
    end
    return
  end

  if delta < 0 then
    if self.row == 1 then
      if haveCandidates then
        self.candidateFocus = true
        self.candidateCol = nearestCol(#self:visibleCandidates(),
          function(c) return CANDIDATE_X0 + (c - 1) * 16 end, x)
      else
        self.row = 4
        self.col = nearestMetaCol(x)
      end
    else
      self.row = self.row - 1
      self.col = nearestCol(#Cangjie.KEY_ROWS[self.row],
        function(c) return keyCellX(self.row, c) end, x)
    end
    return
  end

  if self.row == 4 then
    if haveCandidates then
      self.candidateFocus = true
      self.candidateCol = nearestCol(#self:visibleCandidates(),
        function(c) return CANDIDATE_X0 + (c - 1) * 16 end, x)
    else
      self.row = 1
      self.col = nearestCol(#Cangjie.KEY_ROWS[1],
        function(c) return keyCellX(1, c) end, x)
    end
  elseif self.row == 3 then
    self.row = 4
    self.col = nearestMetaCol(x)
  else
    self.row = self.row + 1
    self.col = nearestCol(#Cangjie.KEY_ROWS[self.row],
      function(c) return keyCellX(self.row, c) end, x)
  end
end

function NamingScreen:activateFocus()
  if self.candidateFocus then
    return self:commitCandidate(self.candidateCol)
  end
  if self.row == 4 then
    if self.col == 1 then
      self:toggleInterface()
    elseif self.col == 2 then
      self:toggleTypingMode()
    else
      if self.ime:isComposing() then
        -- Never throw away an unfinished Cangjie code merely because the
        -- cursor reached 定.  Make the pending candidate choice visible.
        local visible = self:visibleCandidates()
        if #visible > 0 then
          self.candidateFocus = true
          self.candidateCol = math.min(self.candidateCol, #visible)
        end
      else
        self:confirm()
      end
    end
    return true
  end
  return self:pushCode(self:keyCodeAt(self.row, self.col))
end

-- Raw desktop typing.  This screen no longer forwards keys to Input itself.
-- Game:keypressed now supports a backward-compatible "return false to pass
-- through" seam: old all-key capture screens still return nil and keep their
-- old behaviour, while NamingScreen claims only the keys that really belong
-- to direct Cangjie typing.  That keeps key-down/key-up ownership in one place
-- and stops the control map from becoming two half-overlapping systems.
function NamingScreen:onKeyPressed(key)
  if not self.keyboardTyping then
    return false -- ordinary Game/GB keyboard behaviour, completely untouched
  end

  -- In 鍵盤 mode alphabetic keys are the Cangjie keyboard itself.
  if type(key) == "string" and key:match("^[a-z]$") then
    self:pushCode(key)
    return true
  end


  -- LÖVE reports letter keys as lower-case names regardless of Shift.  Because
  -- the ABC page is uppercase-only, a typist may instinctively hold Shift; do
  -- not let that accidental modifier fire the recomp's Shift=SELECT alias and
  -- flip the Cangjie display underneath them.  Tab remains SELECT.
  if key == "lshift" or key == "rshift" then return true end

  -- Number keys are useful, conventional direct-candidate shortcuts and must
  -- be consumed here anyway: Game reserves 1..5 for host display/speed keys.
  if key and key:match("^[1-9]$") then
    if self.ime:isComposing() then self:commitCandidate(tonumber(key)) end
    return true
  end

  -- Space is the one typing-specific non-letter convenience: like a desktop
  -- IME it accepts candidate 1.  Enter remains ordinary Game Boy A, so the
  -- player can ALWAYS navigate to 遊戲兒 and leave keyboard mode.
  if key == "space" and self.ime:isComposing() then
    if #self:visibleCandidates() > 0 then self:commitCandidate(1) end
    return true
  end

  -- Arrows, Enter, Backspace, Escape, Tab/Shift and everything else go through
  -- Game's normal path.  In particular Enter=A and Backspace=B still work, so
  -- enabling direct typing does not create a second control system.
  return false
end

function NamingScreen:update(_dt)
  local input = self.game.input

  if input:wasPressed("start") then
    if self.ime:isComposing() then
      -- START used to silently commit candidate 1, which made candidate choice
      -- feel unpredictable.  During composition it now moves focus to the
      -- candidate row; A performs the actual, visible commitment.
      local visible = self:visibleCandidates()
      if #visible > 0 then
        self.candidateFocus = true
        self.candidateCol = math.min(self.candidateCol, #visible)
      end
    else
      self:confirm()
    end
    return
  end

  if input:wasPressed("select") then
    self:toggleInterface()
    return
  end

  if input:wasPressed("up") then
    self:moveVertical(-1)
  elseif input:wasPressed("down") then
    self:moveVertical(1)
  elseif input:wasPressed("left") then
    self:moveHorizontal(-1)
  elseif input:wasPressed("right") then
    self:moveHorizontal(1)
  else
    -- Prefer A over B if both edges arrive in one frame, matching the old
    -- screen's defence against the gamepad+raw dual-input path.
    local pressedA = input:wasPressed("a")
    local pressedB = input:wasPressed("b")
    if pressedA and pressedB then pressedB = false end

    if pressedB then
      self:backspace()
    elseif pressedA then
      self:activateFocus()
    end
  end
end

local function drawFocusBox(x, y, w, h)
  -- Four filled 1px strips stay sharp under the game's integer scaling and do
  -- not depend on an extra font glyph being present in the translation font.
  love.graphics.rectangle("fill", x, y, w, 1)
  love.graphics.rectangle("fill", x, y + h - 1, w, 1)
  love.graphics.rectangle("fill", x, y, 1, h)
  love.graphics.rectangle("fill", x + w - 1, y, 1, h)
end

local function isHanLabel(text)
  -- Every non-ASCII label on this screen is a Wenjin-rendered CJK glyph.
  return type(text) == "string" and text:find("[\128-\255]") ~= nil
end

local function drawLabelFocus(label, x, y, w)
  if isHanLabel(label) then
    drawFocusBox(x, y + HAN_FOCUS_TOP, w, HAN_FOCUS_H)
  else
    drawFocusBox(x, y + TILE_FOCUS_TOP, w, TILE_FOCUS_H)
  end
end

local function drawCentered(text, x, y, width)
  Font.draw(text, x + math.floor((width - Font.width(text)) / 2), y)
end

function NamingScreen:drawName()
  local slot = 16
  local total = self.maxLen * slot
  local x0 = math.max(0, math.floor((160 - total) / 2))
  for i = 1, self.maxLen do
    if self.glyphs[i] then
      drawCentered(self.glyphs[i], x0 + (i - 1) * slot, 24, slot)
    else
      drawCentered("-", x0 + (i - 1) * slot, 24, slot)
    end
  end
end

function NamingScreen:drawComposition()
  if not self.ime:isComposing() then return end
  local roots = self.ime:roots()
  Font.draw(roots, math.floor((160 - Font.width(roots)) / 2), 40)

  local pages = self.ime:pageCount()
  if pages > 1 then
    local marker = tostring(self.ime.page) .. "/" .. tostring(pages)
    Font.draw(marker, 160 - Font.width(marker), 40)
  end
end

function NamingScreen:drawCandidates()
  local candidates = self:visibleCandidates()
  for c, ch in ipairs(candidates) do
    local x = CANDIDATE_X0 + (c - 1) * 16
    drawCentered(ch, x, CANDIDATE_Y, 16)
    if self.candidateFocus and self.candidateCol == c then
      drawLabelFocus(ch, x, CANDIDATE_Y, 16)
    end
  end
end

function NamingScreen:drawKeyboard()
  for row, codes in ipairs(Cangjie.KEY_ROWS) do
    for col, code in ipairs(codes) do
      local x = keyCellX(row, col)
      local label = self.ime:labelFor(code, self.latin)
      drawCentered(label, x, KEY_Y[row], 16)
      if not self.candidateFocus and self.row == row and self.col == col then
        drawLabelFocus(label, x, KEY_Y[row], 16)
      end
    end
  end

  local labels = self:metaLabels()
  for col, label in ipairs(labels) do
    Font.draw(label, META_X[col], META_Y)
  end
  if not self.candidateFocus and self.row == 4 then
    local label = labels[self.col]
    drawLabelFocus(label, META_X[self.col] - 2, META_Y, Font.width(label) + 4)
  end
end

function NamingScreen:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", 0, 0, 160, 144)
  love.graphics.setColor(0, 0, 0, 1)

  Font.draw(self.title, 8, 8)
  self:drawName()
  self:drawComposition()
  self:drawCandidates()
  self:drawKeyboard()

  love.graphics.setColor(1, 1, 1, 1)
end

return NamingScreen
