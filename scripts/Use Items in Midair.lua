LUAGUI_NAME = "Use Items in Midair"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Use Items in Midair"

--- Game Version Check
epiccheck = 0x585B61
stmcheck = epiccheck+0x2F8
stmjpcheck = epiccheck+0x2A8

function _OnInit()
	if ENGINE_TYPE == "BACKEND" then
	IsEpicGame = 0
	IsSteamGame = 0
	IsSteamJPGame = 0
	end
end

function _OnFrame()	

			if ReadLong(epiccheck) == 0x7265737563697065 and IsEpicGame == 0 then
				IsEpicGame = 1
				ConsolePrint("Use Items in Midair (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Use Items in Midair (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Use Items in Midair (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
				WriteByte(0x3B15D9, 0xEB)
				WriteShort(0x4012CD, 0x9090)
			end
			
			if IsSteamGame == 1 then
				WriteByte(0x3B22F9, 0xEB)
				WriteShort(0x401FED, 0x9090)
			end
	
			if IsSteamJPGame == 1 then
				WriteByte(0x3B2079, 0xEB)
				WriteShort(0x401D6D, 0x9090)
			end
end
