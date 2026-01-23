LUAGUI_NAME = "Auto Cutscene Skip"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Auto Cutscene Skip (optimized)"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = 0x585E59
local stmjpcheck  = 0x585E09
local MAGIC       = 0x7265737563697065

-- Cache API
local ReadLong     = ReadLong
local ReadInt      = ReadInt
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local ConsolePrint = ConsolePrint

-- State
local game = 0          -- 0 unknown, 1 epic, 2 steam, 3 steamjp
local printedReady = false

-- Addresses (set after resolve)
local skipAddr = 0
local frameAddr = 0
local cutsceneAddr = 0
local miniCutsceneAddr = 0

-- Guard to avoid writing every frame while already skipping
local didSkipThisCutscene = false

local function TryResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    ConsolePrint("Auto Cutscene Skip (EPIC GL) - Ready")
    skipAddr         = 0xB64A1C
    frameAddr        = 0xB64A18
    cutsceneAddr     = 0xB64A54
    miniCutsceneAddr = 0xB64A25

  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    ConsolePrint("Auto Cutscene Skip (Steam GL) - Ready")
    skipAddr         = 0xB64F9C
    frameAddr        = 0xB64F98
    cutsceneAddr     = 0xB64FD4
    miniCutsceneAddr = 0xB64FA5

  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    ConsolePrint("Auto Cutscene Skip (Steam JP) - Ready")
    skipAddr         = 0xB64F9C
    frameAddr        = 0xB64F98
    cutsceneAddr     = 0xB64FD4
    miniCutsceneAddr = 0xB64FA5

  else
    return false
  end

  printedReady = true
  return true
end

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    printedReady = false
    skipAddr = 0
    frameAddr = 0
    cutsceneAddr = 0
    miniCutsceneAddr = 0
    didSkipThisCutscene = false
  end
end

function _OnFrame()
  if not TryResolveGame() then return end

  -- Read minimal values once
  local f = ReadInt(frameAddr)
  if f <= 0 then
    didSkipThisCutscene = false
    return
  end

  local isCut = ReadByte(cutsceneAddr)
  if isCut < 1 then
    didSkipThisCutscene = false
    return
  end

  -- Don't skip minigame cutscenes
  local isMini = ReadByte(miniCutsceneAddr)
  if isMini ~= 0 then
    didSkipThisCutscene = false
    return
  end

  -- Only trigger once per cutscene state
  if not didSkipThisCutscene then
    WriteByte(skipAddr, 1)
    didSkipThisCutscene = true
  end
end
