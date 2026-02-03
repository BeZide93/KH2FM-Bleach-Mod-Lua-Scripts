LUAGUI_NAME = "Inject Abilities 457–461"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Press Select / N to inject abilities 457–461"

-- Version checks
local epiccheck  = 0x585B61
local stmcheck   = epiccheck + 0x2F8
local stmjpcheck = epiccheck + 0x2A8
local MAGIC      = 0x7265737563697065

-- Input addresses (Select / N)
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Target base address (matches your screenshot)
local AbilityBase = 0x9ABE8A

-- Ability IDs (shorts)
local abilities = {
  0x01C9, -- 457
  0x01CA, -- 458
  0x01CB, -- 459
  0x01CC, -- 460
  0x01CD  -- 461
}

-- State
local game = 0
local inputAddr = 0
local lastPress = 0
local injected = false

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    inputAddr = 0
    lastPress = 0
    injected = false
  end
end

local function ResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    inputAddr = InputAddrEpic
    ConsolePrint("Ability Injector (EPIC) - Ready")
  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    inputAddr = InputAddrSteam
    ConsolePrint("Ability Injector (Steam) - Ready")
  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    inputAddr = InputAddrSteam
    ConsolePrint("Ability Injector (Steam JP) - Ready")
  else
    return false
  end
  return true
end

function _OnFrame()
  if not ResolveGame() then return end
  if injected then return end

  local pressed = ReadByte(inputAddr)
  if pressed == 1 and lastPress == 0 then
    for i = 1, #abilities do
      WriteShort(AbilityBase + (i - 1) * 2, abilities[i])
    end
    ConsolePrint("Abilities 457–461 injected")
    injected = true
  end

  lastPress = pressed
end
