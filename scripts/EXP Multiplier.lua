LUAGUI_NAME = "EXP Multiplier"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "EXP Multiplier"

EXPMultiplier = 10

epiccheck = 0x585B61
stmcheck = 0x585E59
stmjpcheck = 0x585E09

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
				ConsolePrint("EXP Multiplier (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("EXP Multiplier (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("EXP Multiplier (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
				WriteByte(0x2A2321B, EXPMultiplier)
				WriteByte(0x40FF2D, 0x74)
				WriteShort(0x40FEF2, 0x9090)
				WriteShort(0x40FEFF, 0x9090)
				WriteByte(0x4009B1, EXPMultiplier)
			end
			
			if IsSteamGame == 1 then
				WriteByte(0x2A2379B, EXPMultiplier)
				WriteByte(0x410C4D, 0x74)
				WriteShort(0x410C12, 0x9090)
				WriteShort(0x410C1F, 0x9090)
				WriteByte(0x4016D1, EXPMultiplier)
			end
	
			if IsSteamJPGame == 1 then
				WriteByte(0x2A2379B, EXPMultiplier)
				WriteByte(0x4109CD, 0x74)
				WriteShort(0x410992, 0x9090)
				WriteShort(0x41099F, 0x9090)
				WriteByte(0x401451, EXPMultiplier)
			end
end
