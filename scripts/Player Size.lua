LUAGUI_NAME = "Player Size"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Player Size"

epiccheck = 0x585B61
stmcheck = 0x585E59
stmjpcheck = 0x585E09

SoraSize = 1.15

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
				ConsolePrint("Player Size (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Player Size (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Player Size (Steam JP) - installed")
			end

			if IsEpicGame == 1 then
					sorasizex = ReadLong(0x718AA0)+0x30
					sorasizey = ReadLong(0x718AA0)+0x34
					sorasizez = ReadLong(0x718AA0)+0x38
					WriteFloat(sorasizex, SoraSize, true)
					WriteFloat(sorasizey, SoraSize, true)
					WriteFloat(sorasizez, SoraSize, true)
			end
			
			if IsSteamGame == 1 then
					sorasizex = ReadLong(0x718CB0)+0x30
					sorasizey = ReadLong(0x718CB0)+0x34
					sorasizez = ReadLong(0x718CB0)+0x38
					WriteFloat(sorasizex, SoraSize, true)
					WriteFloat(sorasizey, SoraSize, true)
					WriteFloat(sorasizez, SoraSize, true)
			end
	
			if IsSteamJPGame == 1 then
					sorasizex = ReadLong(0x718CB0)+0x30
					sorasizey = ReadLong(0x718CB0)+0x34
					sorasizez = ReadLong(0x718CB0)+0x38
					WriteFloat(sorasizex, SoraSize, true)
					WriteFloat(sorasizey, SoraSize, true)
					WriteFloat(sorasizez, SoraSize, true)
			end

end