LUAGUI_NAME = "All Armor Accessories"
LUAGUI_AUTH = "Gemini"
LUAGUI_DESC = "Press Select/N to give 20x all Armor and Accessories"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = epiccheck + 0x2F8
local stmjpcheck  = epiccheck + 0x2A8
local MAGIC       = 0x7265737563697065

-- Input addresses (Select/N)
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Base addresses (inventory base you used)
local BaseEpic  = 0x9AC8D1
local BaseSteam = 0x9ACE51

-- Cache API lookups
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local ConsolePrint = ConsolePrint

-- Offsets whitelist (party weapons/dummies excluded)
local OFFSETS = {
  -- RINGS (before Kingdom Key)
  -26, -25, -24, -23, -22, -21, -20, -19, -18, -17, -16, -15, -14,
  -7, -6, -5, -3, -2, -1,

  -- EARRINGS (after Kingdom Key)
  5, 6, 7,
  11, 12,

  -- ACCESSORIES & ARMOR
  15,
  16, 17,
  22, 23, 24, 25, 26,
  27, 28, 29,
  37, 38,
  41,
  48, 49, 50, 51,

  -- ELEMENTAL ARMOR
  54, 55, 56, 57,
  59, 60, 61, 62,
  65, 66, 67, 68,

  -- ANKLETS & HIGH-END ARMOR
  88,
  90, 91, 92,
  94, 95, 96, 97, 98, 99, 100, 101,

  -- FINAL MIX EXTRAS
  276,
}

-- State
local game = 0          -- 0 unknown, 1 epic, 2 steam, 3 steamjp
local inputAddr = 0
local baseAddr = 0
local lastPress = 0
local printedReady = false

local function TryResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    inputAddr = InputAddrEpic
    baseAddr = BaseEpic
  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    inputAddr = InputAddrSteam
    baseAddr = BaseSteam
  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    inputAddr = InputAddrSteam
    baseAddr = BaseSteam
  else
    return false
  end

  if not printedReady then
    if game == 1 then ConsolePrint("Final Clean Gear (EPIC) - Ready")
    elseif game == 2 then ConsolePrint("Final Clean Gear (Steam) - Ready")
    else ConsolePrint("Final Clean Gear (Steam JP) - Ready") end
    printedReady = true
  end
  return true
end

local function WriteFinalGear(base)
  local amount = 20
  for i = 1, #OFFSETS do
    WriteByte(base + OFFSETS[i], amount)
  end
end

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    inputAddr = 0
    baseAddr = 0
    lastPress = 0
    printedReady = false
  end
end

function _OnFrame()
  if not TryResolveGame() then return end

  local pressed = ReadByte(inputAddr)
  if pressed == 1 and lastPress == 0 then
    WriteFinalGear(baseAddr)
    if game == 1 then ConsolePrint("Armor/Accessories added (Epic)!")
    elseif game == 2 then ConsolePrint("Armor/Accessories added (Steam)!")
    else ConsolePrint("Armor/Accessories added (JP)!") end
  end
  lastPress = pressed
end
