-- 1908 Qing 營造尺庫平制 conversions used by the Literary Chinese Pokédex.
--
-- The source Gen I Pokédex stores height as whole feet/inches and weight as
-- tenths of a pound.  We convert those source values into one fixed historical
-- standard rather than mixing measurements from different dynasties:
--
--   1 營造尺 = 32 cm = 10 寸
--   1 庫平斤 = 596.816 g = 16 庫平兩
--
-- The display rounds height to the nearest 寸 and weight to the nearest 兩.
-- That matches the precision of the source data better than printing smaller
-- subdivisions would.

local QingMeasure = {}

QingMeasure.CM_PER_INCH = 2.54
QingMeasure.CUN_CM = 3.2
QingMeasure.CUN_PER_CHI = 10
QingMeasure.CUN_PER_ZHANG = 100

QingMeasure.GRAMS_PER_POUND = 453.59237
QingMeasure.JIN_GRAMS = 596.816
QingMeasure.LIANG_PER_JIN = 16
QingMeasure.LIANG_GRAMS = QingMeasure.JIN_GRAMS / QingMeasure.LIANG_PER_JIN

local function round(n)
  return math.floor(n + 0.5)
end

-- Convert an arbitrary inch measurement to the canonical Pokédex length
-- parts.  Doing the rounding before decomposition means 9.6 寸 correctly
-- carries into 1 尺 rather than printing an impossible "...十寸" tail.
function QingMeasure.lengthFromInches(inches)
  local totalCun = round(math.max(0, tonumber(inches) or 0)
    * QingMeasure.CM_PER_INCH / QingMeasure.CUN_CM)
  local zhang = math.floor(totalCun / QingMeasure.CUN_PER_ZHANG)
  local rest = totalCun % QingMeasure.CUN_PER_ZHANG
  local chi = math.floor(rest / QingMeasure.CUN_PER_CHI)
  local cun = rest % QingMeasure.CUN_PER_CHI
  return { zhang = zhang, chi = chi, cun = cun, totalCun = totalCun }
end

function QingMeasure.lengthFromFeetInches(feet, inches)
  local totalInches = math.max(0, tonumber(feet) or 0) * 12
    + math.max(0, tonumber(inches) or 0)
  return QingMeasure.lengthFromInches(totalInches)
end

-- Generic gram entry point for later reuse outside the Gen I data format.
function QingMeasure.weightFromGrams(grams)
  local totalLiang = round(math.max(0, tonumber(grams) or 0)
    / QingMeasure.LIANG_GRAMS)

  -- Round once at the smallest displayed unit, then decompose into the
  -- official Qing 庫平 units used by the Pokédex.  Keeping the full 斤 count
  -- is intentional: the 1908 standard names no larger weight unit.
  local jin = math.floor(totalLiang / QingMeasure.LIANG_PER_JIN)
  local liang = totalLiang % QingMeasure.LIANG_PER_JIN

  return {
    jin = jin,
    liang = liang,
    totalLiang = totalLiang,
  }
end

-- Gen I stores 150 for 15.0 lb, 190 for 19.0 lb, etc.
function QingMeasure.weightFromTenthsPounds(tenthsPounds)
  local grams = math.max(0, tonumber(tenthsPounds) or 0)
    * QingMeasure.GRAMS_PER_POUND / 10
  return QingMeasure.weightFromGrams(grams)
end

return QingMeasure
