LUAGUI_NAME = "Drive Form Restrction"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Drive Form Restrction"

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
				ConsolePrint("Drive Form Restrction (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Drive Form Restrction (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Drive Form Restrction (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
			WriteByte(0x3F200E, 0x77)
			WriteShort(0x4011A4, 0x820F)
			WriteByte(0x3E2AEC, 0x72)
			WriteShort(0x4011F8, 0x820F)
			WriteByte(0x3FFE34, 0x7D)
			WriteByte(0x3C223E, 0x7D)
			WriteByte(0x3F202A, 0x03)
			end
			
			if IsSteamGame == 1 then
			WriteByte(0x3F2D2E, 0x77)
			WriteShort(0x401EC4, 0x820F)
			WriteByte(0x3E380C, 0x72)
			WriteShort(0x401F18, 0x820F)
			WriteByte(0x400B54, 0x7D)
			WriteByte(0x3C2F5E, 0x7D)
			WriteByte(0x3F2D4A, 0x03)
			end
	
			if IsSteamJPGame == 1 then
			WriteByte(0x3F2AAE, 0x77)
			WriteShort(0x401C44, 0x820F)
			WriteByte(0x3E358C, 0x72)
			WriteShort(0x401C98, 0x820F)
			WriteByte(0x4008D4, 0x7D)
			WriteByte(0x3C2CDE, 0x7D)
			WriteByte(0x3F2ACA, 0x03)
			end
end
