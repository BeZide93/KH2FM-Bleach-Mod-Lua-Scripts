LUAGUI_NAME = "Instant Puzzle Reward"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Press Select/N to activate Instant Puzzle Reward"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = 0x585E59
local stmjpcheck  = 0x585E09
local MAGIC       = 0x7265737563697065

-- Input addresses (Select / N)
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Cache API
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local ConsolePrint = ConsolePrint

-- State
local game = 0
local inputAddr = 0
local patchAddr = 0
local lastPress = 0
local activated = false
local printedReady = false

local PATCH_OPCODE = 0xEB

local function TryResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    inputAddr = InputAddrEpic
    patchAddr = 0x33E16F
  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    inputAddr = InputAddrSteam
    patchAddr = 0x33EDAF
  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    inputAddr = InputAddrSteam
    patchAddr = 0x33EB2F
  else
    return false
  end

  if not printedReady then
    if game == 1 then ConsolePrint("Instant Puzzle Reward (EPIC GL) - Ready")
    elseif game == 2 then ConsolePrint("Instant Puzzle Reward (Steam GL) - Ready")
    else ConsolePrint("Instant Puzzle Reward (Steam JP) - Ready") end
    printedReady = true
  end
  return true
end

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    inputAddr = 0
    patchAddr = 0
    lastPress = 0
    activated = false
    printedReady = false
  end
end

function _OnFrame()
  if not TryResolveGame() then return end
  if activated then return end

  local pressed = ReadByte(inputAddr)
  if pressed == 1 and lastPress == 0 then
    WriteByte(patchAddr, PATCH_OPCODE)
    ConsolePrint("Instant Puzzle Reward activated")
    activated = true
  end
  lastPress = pressed
end
