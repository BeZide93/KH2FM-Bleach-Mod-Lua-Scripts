LUAGUI_NAME = "Munny"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Press Select/N to set Munny"

local MunnyValue = 100000

-- Version checks
local epiccheck  = 0x585B61
local stmcheck   = epiccheck + 0x2F8
local stmjpcheck = epiccheck + 0x2A8
local MAGIC      = 0x7265737563697065

-- Input addresses (Select/N)
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Munny addresses
local EpicMunny   = 0x9AB770
local SteamMunny  = EpicMunny + 0x580
local SteamJPMunny = EpicMunny + 0x580

-- Cache API
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteInt     = WriteInt
local ConsolePrint = ConsolePrint

-- State
local game = 0          -- 0 unknown, 1 epic, 2 steam, 3 steamjp
local inputAddr = 0
local munnyAddr = 0
local lastPress = 0
local printedReady = false

local function TryResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    inputAddr = InputAddrEpic
    munnyAddr = EpicMunny
  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    inputAddr = InputAddrSteam
    munnyAddr = SteamMunny
  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    inputAddr = InputAddrSteam
    munnyAddr = SteamJPMunny
  else
    return false
  end

  if not printedReady then
    if game == 1 then ConsolePrint("Munny (EPIC GL) - Ready")
    elseif game == 2 then ConsolePrint("Munny (Steam GL) - Ready")
    else ConsolePrint("Munny (Steam JP) - Ready") end
    printedReady = true
  end
  return true
end

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    inputAddr = 0
    munnyAddr = 0
    lastPress = 0
    printedReady = false
  end
end

function _OnFrame()
  if not TryResolveGame() then return end

  local pressed = ReadByte(inputAddr)
  if pressed == 1 and lastPress == 0 then
    WriteInt(munnyAddr, MunnyValue)
    ConsolePrint("Munny set to "..MunnyValue)
  end
  lastPress = pressed
end
