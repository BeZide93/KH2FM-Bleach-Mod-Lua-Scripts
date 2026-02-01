LUAGUI_NAME = "Softreset"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Softreset"

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
				ConsolePrint("Softreset (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Softreset (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Softreset (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
				if ReadByte(0x29FAE41) == 0x0F and ReadByte(0x29FAE40) == 0x09 then
					WriteByte(0xABA6DA, 1)
				end
			end
			
			if IsSteamGame == 1 then
				if ReadByte(0xBF3271) == 0x0F and ReadByte(0xBF3270) == 0x09 then
					WriteByte(0xABAC5A, 1)
				end
			end
	
			if IsSteamJPGame == 1 then
				if ReadByte(0xBF3271) == 0x0F and ReadByte(0xBF3270) == 0x09 then
					WriteByte(0xABAC5A, 1)
				end
			end
end
