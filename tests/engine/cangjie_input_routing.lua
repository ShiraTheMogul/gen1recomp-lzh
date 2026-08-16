-- Integration smoke test for NamingScreen's raw-key ownership seam.
-- It models Game:keypressed's new contract using the REAL Input module so
-- press/release bookkeeping and the stock keyboard map are exercised too.

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

local Input = require("src.core.Input")
Input:init()
local NamingScreen = require("src.ui.NamingScreen")

local game = { data = {}, input = Input }
game.stack = { push = function() end, pop = function() end }
local ns = NamingScreen.new(game, { title = "TEST?", maxLen = 7 })

local function routePress(key)
  local handled = ns:onKeyPressed(key)
  if handled == false then Input:keypressed(key) end
  Input:step()
  ns:update(0)
  Input:keyreleased(key)
  Input:step()
  ns:update(0)
end

-- Enter follows the ordinary A binding into 鍵盤 mode.
ns.row, ns.col = 4, 2
routePress("return")
check(ns.keyboardTyping, "Enter=A activates 鍵盤 through normal Input")

-- Raw letters are now owned only by the IME.
routePress("q")
routePress("m")
routePress("b")
eq(ns.ime.code, "qmb", "QMB composed without leaking GB directions/buttons")

-- Backspace is NOT a second IME path: normal Backspace=B reaches update(),
-- which applies the screen's ordinary B semantics.
routePress("backspace")
eq(ns.ime.code, "qm", "Backspace=B removes one Cangjie code")
routePress("b") -- raw B is a Cangjie letter in keyboard mode
eq(ns.ime.code, "qmb", "alphabetic B remains a Cangjie typing key")

-- This was the broken path in v2: Enter used to be swallowed by the IME while
-- composing, making 遊戲兒 effectively inaccessible.  It must remain A.
ns.row, ns.col = 4, 2
routePress("return")
check(not ns.keyboardTyping, "Enter=A can leave 鍵盤 mode with composition pending")
eq(ns.ime.code, "qmb", "mode switch does not destroy pending composition")

-- Once back in Game Boy mode WASD and Z/X are ordinary controls again.
ns.row, ns.col = 1, 1
routePress("d")
eq(ns.col, 2, "D returns to normal right movement in Game Boy mode")

print("cangjie input routing: ok")
