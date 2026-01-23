LUAGUI_NAME = "Gauge Speed"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Gauge Speed"

--- Game Version Check
epiccheck = 0x585B61
stmcheck = epiccheck+0x2F8
stmjpcheck = epiccheck+0x2A8

DriveSpeed = 0.001
SummonSpeed = 0.1
LimitSpeed = 0.1

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
				ConsolePrint("Gauge Speed (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Gauge Speed (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Gauge Speed (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
DriveGauge = 0x2A2322C
SummonGauge = 0x2A23258
LimitGauge = 0x2A2324C
WriteFloat(DriveGauge, DriveSpeed)
WriteFloat(SummonGauge, SummonSpeed)
WriteFloat(LimitGauge, LimitSpeed)
			end
			
			if IsSteamGame == 1 then
DriveGauge = 0x2A237AC
SummonGauge = 0x2A237D8
LimitGauge = 0x2A237CC
WriteFloat(DriveGauge, DriveSpeed)
WriteFloat(SummonGauge, SummonSpeed)
WriteFloat(LimitGauge, LimitSpeed)
			end
	
			if IsSteamJPGame == 1 then
DriveGauge = 0x2A237AC
SummonGauge = 0x2A237D8
LimitGauge = 0x2A237CC
WriteFloat(DriveGauge, DriveSpeed)
WriteFloat(SummonGauge, SummonSpeed)
WriteFloat(LimitGauge, LimitSpeed)
			end
end
