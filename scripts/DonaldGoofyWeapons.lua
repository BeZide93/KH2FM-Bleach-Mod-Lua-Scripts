LUAGUI_NAME = "Donald & Goofy Weapons"
LUAGUI_AUTH = "Gemini"
LUAGUI_DESC = "Press Select/N to give all Donald & Goofy weapons"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = epiccheck + 0x2F8
local stmjpcheck  = epiccheck + 0x2A8
local MAGIC       = 0x7265737563697065

-- Input addresses (Select / N)
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Inventory base addresses
local BaseEpic  = 0x9AC8D1
local BaseSteam = 0x9ACE51

-- Cache API
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local ConsolePrint = ConsolePrint

-- Party weapon offsets (relative to Kingdom Key)
local OFFSETS = {
    -- === GOOFY SHIELDS ===
    8, 9, 10,
    69, 70, 71, 72, 73, 74, 75, 76, 77,
    221, 242,
    256, 257, 258, 259, 260, 261, 262,
    278,

    -- === DONALD STAVES ===
    34,
    78, 79, 80, 81, 82, 83, 84, 85, 86,
    220, 241,
    249, 250,
    251, 252, 253, 254, 255,
    277
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
        if game == 1 then ConsolePrint("DG Weapons (EPIC) - Ready")
        elseif game == 2 then ConsolePrint("DG Weapons (Steam) - Ready")
        else ConsolePrint("DG Weapons (Steam JP) - Ready") end
        printedReady = true
    end
    return true
end

local function GivePartyWeapons(base)
    local amount = 1
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
        GivePartyWeapons(baseAddr)
        if game == 1 then ConsolePrint("Donald & Goofy weapons added (Epic)!")
        elseif game == 2 then ConsolePrint("Donald & Goofy weapons added (Steam)!")
        else ConsolePrint("Donald & Goofy weapons added (JP)!") end
    end
    lastPress = pressed
end
