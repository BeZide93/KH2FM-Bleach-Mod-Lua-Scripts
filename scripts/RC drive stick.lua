LUAGUI_NAME = "RC Drive Stick (Real Addr + Unlock Check)"
LUAGUI_AUTH = "KSX / BeZide / Gemini"
LUAGUI_DESC = "Checks 0x9ACDD4 (State) and 0x9ACF70 (Unlocks)"

stmcheck = 0x585E59
local canExecute = false

function _OnInit()
    if ENGINE_TYPE == "BACKEND" then
        IsEpicGame = 0
        IsSteamGame = 0
        IsSteamJPGame = 0
    end
end

function _OnFrame()
    if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
        IsSteamGame = 1
        ConsolePrint("RC Drive (Unlock Check) - Ready")
    end     

    if IsSteamGame == 1 then
        
        -- ADRESSEN
        local Button1Addr = 0xBF3271 
        local Button2Addr = 0xBF3270 
        local StickAddr = 0xBF3272
        
        local ForceEnable1 = 0x2A1115C
        local ForceEnable2 = 0x2A11165
        local RCID = 0x2A11162

        -- 1. STATUS ADRESS
        local FormAddr = 0x9ACDD4
        
        -- 2. UNLOCK ADRESS
        local UnlockAddr = 0x9ACF70
	local UnlockAddr2 = 0x9ACF7A

        local b1 = ReadByte(Button1Addr)
        local b2 = ReadByte(Button2Addr)
        local stick = ReadByte(StickAddr)
        
        local currentForm = ReadByte(FormAddr)
        local unlockedForms = ReadByte(UnlockAddr)
	local unlockedForms2 = ReadByte(UnlockAddr2)
        
        -- L2 pressed
        if (b1 & 0x01) == 0x01 then
            
            -- REVERT (L2 + L3) - always available
            if (b2 & 0x02) == 0x02 then
                SetRC(RCID, ForceEnable1, ForceEnable2, 0x05)
                return
            end

            -- LOGIC
            if currentForm > 0 then
                -- === IN DRIVE ===
                -- EVERY INPUT = REVERT (0x05)
                
                local anyInput = false
                if (b1 & 0x09) == 0x09 then anyInput = true end -- R1
                if (b2 & 0x04) == 0x04 then anyInput = true end -- R3
                if (stick & 0xF0) ~= 0 or (stick & 0x0F) ~= 0 then anyInput = true end -- Stick

                if anyInput then
                    SetRC(RCID, ForceEnable1, ForceEnable2, 0x05)
                end

            else
                -- === BASE ===
                -- Cheack wich drive is unlocked
                
                -- FINAL FORM (L2 + R1) 
                -- Check Bit 0x10
                if (b1 & 0x09) == 0x09 then
                    if (unlockedForms & 0x10) == 0x10 then
                        SetRC(RCID, ForceEnable1, ForceEnable2, 0x0C)
                    else
                        ConsolePrint("Final Form locked!")
                    end

                -- ANTI FORM (L2 + R3)
                -- Anti available with Final
                elseif (b2 & 0x04) == 0x04 then
                    if (unlockedForms & 0x10) == 0x10 then
                        SetRC(RCID, ForceEnable1, ForceEnable2, 0x0D)
                    else
                        ConsolePrint("Anti Form locked!")
                    end

                -- STICK UP -> Master Form (0x0B)
                -- Check Bit 0x40
                elseif (stick & 0x80) == 0x80 then
                    if (unlockedForms & 0x40) == 0x40 then
                        SetRC(RCID, ForceEnable1, ForceEnable2, 0x0B)
                    else
                        ConsolePrint("Master Form locked!")
                    end

                -- STICK DOWN -> Limit Form (0x02A1)
                -- Check Address 0x9ACF74 (New), Bit 0x01
                elseif (stick & 0x20) == 0x20 then
                    if (unlockedForms2 & 0x08) == 0x08 then
                        SetIntRC(RCID, ForceEnable1, ForceEnable2, 0x02A1)
                    else
                        ConsolePrint("Limit Form locked!")
                    end

                -- STICK LEFT -> Wisdom Form (0x07)
                -- Check Bit 0x04
                elseif (stick & 0x40) == 0x40 then
                    if (unlockedForms & 0x04) == 0x04 then
                        SetRC(RCID, ForceEnable1, ForceEnable2, 0x07)
                    else
                        ConsolePrint("Wisdom Form locked!")
                    end
                
                -- STICK RIGHT -> Valor Form (0x06)
                -- Check Bit 0x02
                elseif (stick & 0x10) == 0x10 then
                    if (unlockedForms & 0x02) == 0x02 then
                        SetRC(RCID, ForceEnable1, ForceEnable2, 0x06)
                    else
                        ConsolePrint("Valor Form locked!")
                    end
                    
                else
                    ResetRC(ForceEnable1, ForceEnable2)
                end
            end
            
        else
            ResetRC(ForceEnable1, ForceEnable2)
        end
    end
end

-- Helper
function SetRC(addr, f1, f2, val)
    WriteByte(f1, 0)
    WriteByte(f2, 0)
    WriteShort(addr, val)
end

function SetIntRC(addr, f1, f2, val)
    WriteByte(f1, 0)
    WriteByte(f2, 0)
    WriteInt(addr, val)
end

function ResetRC(f1, f2)
    WriteByte(f1, 1)
    WriteByte(f2, 1)
end
