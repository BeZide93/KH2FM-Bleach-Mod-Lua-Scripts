LUAGUI_NAME = "All Materials"
LUAGUI_AUTH = "Gemini"
LUAGUI_DESC = "Press Select/N to give Materials"

-- Version checks
local epiccheck   = 0x585B61
local stmcheck    = epiccheck + 0x2F8
local stmjpcheck  = epiccheck + 0x2A8
local MAGIC       = 0x7265737563697065

-- Input addresses
local InputAddrEpic  = 0x29FAE40
local InputAddrSteam = 0xBF3270

-- Cache API lookups (faster than globals in tight loops)
local ReadLong     = ReadLong
local ReadByte     = ReadByte
local WriteByte    = WriteByte
local ConsolePrint = ConsolePrint

-- State
local game = 0              -- 0 unknown, 1 epic, 2 steam, 3 steamjp
local inputAddr = 0
local baseAddress = 0
local lastPress = 0
local printedReady = false

function _OnInit()
    if ENGINE_TYPE == "BACKEND" then
        game = 0
        inputAddr = 0
        baseAddress = 0
        lastPress = 0
        printedReady = false
    end
end

-- Resolve version once (and stop doing it every frame)
local function TryResolveGame()
    if game ~= 0 then return true end

    if ReadLong(epiccheck) == MAGIC then
        game = 1
        inputAddr = InputAddrEpic
        baseAddress = 0x9AC8D1
    elseif ReadLong(stmcheck) == MAGIC then
        game = 2
        inputAddr = InputAddrSteam
        baseAddress = 0x9ACE51
    elseif ReadLong(stmjpcheck) == MAGIC then
        game = 3
        inputAddr = InputAddrSteam
        baseAddress = 0x9ACE51
    else
        return false
    end

    if not printedReady then
        if game == 1 then ConsolePrint("Clean Materials (EPIC GL) - Ready")
        elseif game == 2 then ConsolePrint("Clean Materials (Steam GL) - Ready")
        else ConsolePrint("Clean Materials (Steam JP) - Ready") end
        printedReady = true
    end
    return true
end

function _OnFrame()
    -- If not resolved yet, keep trying (cheap) and do nothing else
    if not TryResolveGame() then return end

    -- Edge-trigger input: only on 0->1 transition
    local pressed = ReadByte(inputAddr)
    if pressed == 1 and lastPress == 0 then
        WriteSafeMaterials(baseAddress)
        if game == 1 then ConsolePrint("Materials added (Epic)!")
        elseif game == 2 then ConsolePrint("Materials added (Steam)!")
        else ConsolePrint("Materials added (JP)!") end
    end
    lastPress = pressed
end

function WriteSafeMaterials(baseAddress)
    local matStart = baseAddress + 0x6E

    -- 0-43
    for i = 0, 43 do WriteByte(matStart + i, 99) end
    -- Orichalcum+ (7)
    WriteByte(matStart + 44, 7)
    -- 60-64
    for i = 60, 64 do WriteByte(matStart + i, 99) end
    -- 91-94
    for i = 91, 94 do WriteByte(matStart + i, 99) end
    -- 153-162
    for i = 153, 162 do WriteByte(matStart + i, 99) end
end
