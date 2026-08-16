-- Literary Chinese Pokédex measurement conversion.
-- The Gen I source data is imperial; display values use the Qing 1908
-- 營造尺庫平制 and round only to the precision justified by the ROM data.
package.path = "./?.lua;./?/init.lua;" .. package.path

local T = require("tests.modkit")
local Qing = require("src.core.QingMeasure")

local function eq(actual, expected, label)
  T.eq(actual, expected, label)
end

-- Bulbasaur: 2'4", 15.0 lb -> 二尺二寸, 十一斤六兩.
local h = Qing.lengthFromFeetInches(2, 4)
eq(h.zhang, 0, "Bulbasaur has no 丈 component")
eq(h.chi, 2, "Bulbasaur Qing 尺")
eq(h.cun, 2, "Bulbasaur Qing 寸")

local w = Qing.weightFromTenthsPounds(150)
eq(w.jin, 11, "Bulbasaur Qing 斤")
eq(w.liang, 6, "Bulbasaur Qing 兩")

-- Onix is tall enough to exercise 丈 decomposition and carry handling.
h = Qing.lengthFromFeetInches(28, 10)
eq(h.zhang, 2, "Onix Qing 丈")
eq(h.chi, 7, "Onix Qing 尺")
eq(h.cun, 5, "Onix Qing 寸")

-- Generic entry points keep the arithmetic reusable for a future converter.
h = Qing.lengthFromInches(12.59842519685) -- essentially one 32 cm 尺
eq(h.chi, 1, "32 cm reconstructs one Qing 尺")
eq(h.cun, 0, "one Qing 尺 has no 寸 remainder")

w = Qing.weightFromGrams(596.816)
eq(w.jin, 1, "596.816 g reconstructs one Qing 斤")
eq(w.liang, 0, "one Qing 斤 has no 兩 remainder")

-- Snorlax: 1014.0 lb stays in the official Qing 斤/兩 hierarchy.
-- Typography, not an invented upper unit, handles the long Pokédex value.
w = Qing.weightFromTenthsPounds(10140)
eq(w.jin, 770, "Snorlax Qing 斤")
eq(w.liang, 11, "Snorlax Qing 兩")
