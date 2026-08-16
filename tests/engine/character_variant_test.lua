-- OpenCC-backed Han display variants.  Source text remains Traditional;
-- Simplified/Shinjitai conversion is presentation-only and deterministic.
package.path = "./?.lua;./?/init.lua;" .. package.path

local T = require("tests.modkit")
local Variant = require("src.core.CharacterVariant")
local SaveData = require("src.core.SaveData")

local function eq(actual, expected, label)
  T.eq(actual, expected, label)
end

Variant.reset()
eq(Variant.convert("漢字體學國龍龜"), "漢字體學國龍龜",
  "Traditional mode preserves canonical source")

eq(Variant.convert("漢字體學國龍龜後發", "simplified"),
  "汉字体学国龙龟后发", "Traditional converts to Simplified")

-- Phrase matching must win over the bare-character mapping 乾 -> 干.
eq(Variant.convert("乾隆乾", "simplified"), "乾隆干",
  "OpenCC phrase mapping precedes character fallback")

-- Do not opt into OpenCC's Extension-B tofu-risk table: the bundled font
-- has 䝻 but not the rare simplified replacement 𧹕.
eq(Variant.convert("䝻", "simplified"), "䝻",
  "rare supported glyph is preserved instead of producing tofu")

eq(Variant.convert("國學體龍龜會號來變氣圖聲樂醫舊寶處萬兩圓讀寫藥",
                   "shinjitai"),
  "国学体竜亀会号来変気図声楽医旧宝処万両円読写薬",
  "Traditional/kyujitai converts to Shinjitai")

eq(Variant.cycle("traditional", 1), "simplified", "cycle right")
eq(Variant.cycle("traditional", -1), "shinjitai", "cycle left wraps")

Variant.applyOptions({ hanVariant = "simplified" })
eq(Variant.convert("漢字"), "汉字", "applyOptions changes live display mode")

eq(SaveData.defaultOptions().hanVariant, "traditional",
  "old/missing options default to Traditional")
eq(SaveData.mergeOptions({ hanVariant = "shinjitai" }).hanVariant, "shinjitai",
  "saved Han variant survives option merge")

T.finish("character variants")
