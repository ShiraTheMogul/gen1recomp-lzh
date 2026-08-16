-- Focused smoke test for the Gen 1 Cangjie naming screen.
-- Run from the repository root:
--   luajit tests/engine/cangjie_naming.lua

package.path = "./?.lua;./?/init.lua;" .. package.path

local T = require("tests.harness")
local check, eq = T.check, T.eq
love = love or require("tests.love_stub")

package.loaded["src.render.Font"] = {
  draw = function() end,
  width = function(s) return #s end,
}
package.loaded["src.core.Sound"] = { play = function() end }
package.loaded["src.core.Strings"] = function(s) return s end

local NamingScreen = require("src.ui.NamingScreen")
local Cangjie = require("src.input.Cangjie")

local game = { data = {} }
game.stack = { push = function() end, pop = function() end }
game.input = {
  queue = {},
  wasPressed = function(self, key) return self.queue[key] or false end,
}

local function press(screen, key)
  game.input.queue = { [key] = true }
  screen:update(0)
  game.input.queue = {}
end

local ns = NamingScreen.new(game, { title = "TEST?", maxLen = 7 })

check(not ns.latin, "Cangjie naming begins on the Han-root page")
check(not ns.keyboardTyping, "Cangjie naming begins in Game Boy control mode")
eq(table.concat(ns:grid()[1], ""), "手田水口廿卜山戈人心", "QWERTY root row")
eq(table.concat(ns:grid()[2], ""), "日尸木火土竹十大中", "ASDF root row")
eq(table.concat(ns:grid()[3], ""), "符難金女月弓一", "ZXCV root row")
eq(table.concat(ns:grid()[4], "|"), "ABC|鍵盤|定", "default bottom actions")

press(ns, "select")
check(ns.latin, "SELECT switches to Latin labels")
eq(table.concat(ns:grid()[1], ""), "QWERTYUIOP", "Latin QWERTY row")
eq(table.concat(ns:grid()[2], ""), "ASDFGHJKL", "Latin ASDF row")
eq(table.concat(ns:grid()[3], ""), "ZXCVBNM", "Latin ZXCV row")
press(ns, "select")
check(not ns.latin, "SELECT switches back to Han roots")

local cj = Cangjie.new()
for ch in ("qmb"):gmatch(".") do check(cj:push(ch), "QMB accepts " .. ch) end
eq(cj:roots(), "手一月", "QMB displays as 手一月")
eq(cj:visibleCandidates()[1], "青", "QMB resolves to 青")

-- The crucial routing contract: default mode claims NO raw desktop keys.
-- Game:keypressed is responsible for passing false-returned keys through the
-- ordinary engine binding path.
eq(ns:onKeyPressed("q"), false, "Game Boy mode passes Q through")
eq(ns:onKeyPressed("backspace"), false, "Game Boy mode passes Backspace through")
eq(ns.ime.code, "", "Game Boy mode does not compose from raw keys")

-- Opt in using the ordinary Game Boy A action on the middle item.
ns.row, ns.col = 4, 2
press(ns, "a")
check(ns.keyboardTyping, "middle item enables direct keyboard Cangjie")
eq(table.concat(ns:grid()[4], "|"), "ABC|遊戲兒|定", "keyboard mode offers Game Boy return")

-- Only typing-specific keys are claimed.  Enter/Backspace remain normal GB A/B.
eq(ns:onKeyPressed("return"), false, "Enter remains Game Boy A")
eq(ns:onKeyPressed("backspace"), false, "Backspace remains Game Boy B")
eq(ns:onKeyPressed("up"), false, "arrows remain ordinary navigation")
check(ns:onKeyPressed("lshift"), "Shift is neutralised in keyboard typing mode")
eq(ns:onKeyPressed("tab"), false, "Tab remains SELECT")

check(ns:onKeyPressed("q"), "keyboard mode claims Q")
check(ns:onKeyPressed("m"), "keyboard mode claims M")
check(ns:onKeyPressed("b"), "keyboard mode claims B")
eq(ns.ime.code, "qmb", "keyboard mode enters Cangjie letters")
check(ns:onKeyPressed("space"), "Space is consumed as IME accept while composing")
eq(ns.glyphs[1], "青", "Space commits first exact candidate")
eq(ns.ime.code, "", "commit clears composition")

-- GB B still edits the composition because Backspace/X reaches normal Input.
ns:onKeyPressed("m")
ns:onKeyPressed("l")
eq(ns.ime.code, "ml", "new composition starts")
press(ns, "b")
eq(ns.ime.code, "m", "B deletes one Cangjie key")
press(ns, "b")
eq(ns.ime.code, "", "B empties composition")
eq(ns.glyphs[1], "青", "composition deletion leaves committed name intact")
press(ns, "b")
eq(#ns.glyphs, 0, "B then deletes committed name glyph")

-- Candidate navigation is a symmetric vertical ring.  From the bottom actions,
-- DOWN reaches candidates directly; from candidates DOWN reaches row 1.
for ch in ("qmb"):gmatch(".") do ns:onKeyPressed(ch) end
ns.row, ns.col = 4, 2
ns.candidateFocus = false
press(ns, "down")
check(ns.candidateFocus, "down from actions reaches candidate row")
press(ns, "down")
check(not ns.candidateFocus and ns.row == 1, "down from candidates reaches QWERTY row 1")
ns.row, ns.col = 1, 2
press(ns, "up")
check(ns.candidateFocus, "up from QWERTY row 1 reaches candidates")

-- START no longer silently commits candidate 1: it merely makes the choice
-- visible by focusing the candidate row.
ns.candidateFocus = false
ns.row, ns.col = 2, 2
local before = #ns.glyphs
press(ns, "start")
eq(#ns.glyphs, before, "START does not silently commit a candidate")
check(ns.candidateFocus, "START focuses candidates while composing")

-- A visibly chooses the focused candidate.
press(ns, "a")
eq(ns.glyphs[#ns.glyphs], "青", "A commits the visibly focused candidate")
eq(ns.ime.code, "", "candidate A commit clears composition")

-- 定 must not discard an unfinished code; it redirects to visible candidates.
ns:onKeyPressed("q")
ns:onKeyPressed("m")
ns:onKeyPressed("b")
ns.row, ns.col = 4, 3
ns.candidateFocus = false
press(ns, "a")
check(ns.candidateFocus, "定 focuses candidates instead of discarding composition")
eq(ns.ime.code, "qmb", "定 preserves unfinished composition")
-- Clear for the mode-switch test.
while ns.ime:isComposing() do ns:backspace() end

-- Keyboard mode can ALWAYS be left with ordinary Enter=A, even if a composition
-- exists, because Enter is not captured by direct typing anymore.
ns:onKeyPressed("m")
ns.row, ns.col = 4, 2
check(ns:onKeyPressed("return") == false, "Enter passes to normal A while composing")
press(ns, "a")
check(not ns.keyboardTyping, "A on 遊戲兒 exits keyboard mode")
eq(ns.ime.code, "m", "switching control mode preserves composition")

ns:draw()
print("cangjie naming: ok")
