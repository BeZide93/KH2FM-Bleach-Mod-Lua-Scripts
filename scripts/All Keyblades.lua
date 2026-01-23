LUAGUI_NAME = "All Keyblades"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Press Select/N to give all Keyblades"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = epiccheck + 0x2F8
local stmjpcheck  = epiccheck + 0x2A8
local MAGIC       = 0x7265737563697065

-- Input addresses (Select/N)
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Cache API lookups
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local ConsolePrint = ConsolePrint

-- State
local game = 0          -- 0 unknown, 1 epic, 2 steam, 3 steamjp
local inputAddr = 0
local kingdomkey = 0
local lastPress = 0
local printedReady = false

-- Keyblade offsets relative to kingdomkey base
local OFFSETS = {
  0x00, -- kingdomkey
  0x01, -- oathkeeper
  0x02, -- oblivion
  0xDA, -- starseeker
  0xDB, -- hiddendragon
  0xDE, -- heroscrest
  0xDF, -- monochrome
  0xE0, -- followthewind
  0xE1, -- circleoflife
  0xE2, -- photondebugger
  0xE3, -- gullwing
  0xE4, -- rumblingrose
  0xE5, -- guardiansoul
  0xE6, -- wishinglamp
  0xE7, -- decisivepumpkin
  0xE8, -- sleepinglion
  0xE9, -- sweetmemories
  0xEA, -- mysteriousabyss
  0xEB, -- fatalcrest
  0xEC, -- bondofflame
  0xED, -- fenrir
  0xEE, -- ultimaweapon
  0xF7, -- twobecomeone
  0xF8, -- winnersproof
  0x03, -- detectionsaber
  0x04, -- frontierofultima
  0x1E, -- antiformdummy
  0x28, -- fake
  0xB0, -- strugglesword
  0xEF, -- strugglewand
  0xF0, -- strugglehammer
}

local function TryResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    inputAddr = InputAddrEpic
    kingdomkey = 0x9AC8D1
  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    inputAddr = InputAddrSteam
    kingdomkey = 0x9ACE51
  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    inputAddr = InputAddrSteam
    kingdomkey = 0x9ACE51
  else
    return false
  end

  if not printedReady then
    if game == 1 then ConsolePrint("All Keyblades (EPIC GL) - Ready")
    elseif game == 2 then ConsolePrint("All Keyblades (Steam GL) - Ready")
    else ConsolePrint("All Keyblades (Steam JP) - Ready") end
    printedReady = true
  end
  return true
end

local function GiveAllKeyblades()
  -- 9 seems to be your intended quantity/state
  for i = 1, #OFFSETS do
    WriteByte(kingdomkey + OFFSETS[i], 9)
  end
end

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    inputAddr = 0
    kingdomkey = 0
    lastPress = 0
    printedReady = false
  end
end

function _OnFrame()
  if not TryResolveGame() then return end

  local pressed = ReadByte(inputAddr)
  if pressed == 1 and lastPress == 0 then
    GiveAllKeyblades()
    if game == 1 then ConsolePrint("Keyblades added (Epic)!")
    elseif game == 2 then ConsolePrint("Keyblades added (Steam)!")
    else ConsolePrint("Keyblades added (JP)!") end
  end
  lastPress = pressed
end
