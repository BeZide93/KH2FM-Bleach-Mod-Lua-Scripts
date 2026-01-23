LUAGUI_NAME = "Auto Atlantica"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Auto Atlantica (optimized, no input)"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = epiccheck + 0x2F8
local stmjpcheck  = epiccheck + 0x2A8
local MAGIC       = 0x7265737563697065

-- Cache API
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local WriteInt     = WriteInt
local ConsolePrint = ConsolePrint

-- State
local game = 0          -- 0 unknown, 1 epic, 2 steam, 3 steamjp
local printedReady = false

-- Addresses (set after version resolve)
local worldid, roomid, spawnid, event1id, event2id, event3id = 0,0,0,0,0,0
local atlanticascore, atlanticascore2, atlanticascore3 = 0,0,0

-- Guard so we don't write every frame
-- We store the last "signature" of (room + events) we've handled.
local lastSig = -1

local function TryResolveGame()
  if game ~= 0 then return true end

  if ReadLong(epiccheck) == MAGIC then
    game = 1
    ConsolePrint("Auto Atlantica (EPIC GL) - Ready")
    -- EPIC addresses
    worldid = 0x716DF8
    roomid  = 0x716DF9
    spawnid = 0x716DFA
    event1id = 0x716DFC
    event2id = 0x716DFE
    event3id = 0x716E00
    atlanticascore  = 0xB65804
    atlanticascore2 = 0xB657F8
    atlanticascore3 = 0xB657F4

  elseif ReadLong(stmcheck) == MAGIC then
    game = 2
    ConsolePrint("Auto Atlantica (Steam GL) - Ready")
    -- STEAM addresses
    worldid = 0x717008
    roomid  = 0x717009
    spawnid = 0x71700A
    event1id = 0x71700C
    event2id = 0x71700E
    event3id = 0x717010
    atlanticascore  = 0xB65D84
    atlanticascore2 = 0xB65D78
    atlanticascore3 = 0xB65D74

  elseif ReadLong(stmjpcheck) == MAGIC then
    game = 3
    ConsolePrint("Auto Atlantica (Steam JP) - Ready")
    -- STEAM JP uses same as Steam in your script
    worldid = 0x717008
    roomid  = 0x717009
    spawnid = 0x71700A
    event1id = 0x71700C
    event2id = 0x71700E
    event3id = 0x717010
    atlanticascore  = 0xB65D84
    atlanticascore2 = 0xB65D78
    atlanticascore3 = 0xB65D74

  else
    return false
  end

  printedReady = true
  return true
end

-- Helper: check if we're in a specific event triple (all equal)
local function EventsAre(e1, e2, e3, v)
  return (e1 == v and e2 == v and e3 == v)
end

function _OnInit()
  if ENGINE_TYPE == "BACKEND" then
    game = 0
    printedReady = false
    lastSig = -1
    worldid, roomid, spawnid, event1id, event2id, event3id = 0,0,0,0,0,0
    atlanticascore, atlanticascore2, atlanticascore3 = 0,0,0
  end
end

function _OnFrame()
  if not TryResolveGame() then return end

  -- Read once per frame
  local w = ReadByte(worldid)
  if w ~= 0x0B then
    lastSig = -1 -- reset guard when leaving Atlantica
    return
  end

  local r  = ReadByte(roomid)
  local sp = ReadByte(spawnid)
  if sp ~= 0 then return end

  local e1 = ReadByte(event1id)
  local e2 = ReadByte(event2id)
  local e3 = ReadByte(event3id)

  -- Build a small signature so we only act once per state
  -- (room + e1) is usually enough since e1/e2/e3 match in your conditions.
  local sig = r * 256 + e1
  if sig == lastSig then return end
  lastSig = sig

  -- ROOM 0x04: event 0x40 or 0x42 -> score byte 0
  if r == 0x04 and (EventsAre(e1,e2,e3,0x40) or EventsAre(e1,e2,e3,0x42)) then
    WriteByte(atlanticascore, 0)
    return
  end

  -- ROOM 0x01: event 0x33 or 0x43 -> score2 = 999
  if r == 0x01 and (EventsAre(e1,e2,e3,0x33) or EventsAre(e1,e2,e3,0x43)) then
    WriteInt(atlanticascore2, 999)
    return
  end

  -- ROOM 0x03: event 0x35 or 0x44 -> score3 = 10000
  if r == 0x03 and (EventsAre(e1,e2,e3,0x35) or EventsAre(e1,e2,e3,0x44)) then
    WriteInt(atlanticascore3, 10000)
    return
  end

  -- ROOM 0x09: event 0x41 or 0x45 -> score3 = 10000
  if r == 0x09 and (EventsAre(e1,e2,e3,0x41) or EventsAre(e1,e2,e3,0x45)) then
    WriteInt(atlanticascore3, 10000)
    return
  end

  -- ROOM 0x04: event 0x37 or 0x46 -> score3 = 999999
  if r == 0x04 and (EventsAre(e1,e2,e3,0x37) or EventsAre(e1,e2,e3,0x46)) then
    WriteInt(atlanticascore3, 999999)
    return
  end
end
