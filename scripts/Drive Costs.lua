LUAGUI_NAME = "Drive Costs"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Drive Costs"

Valor = 0
Wisdom = 0
Limit = 0
Master = 0
Final = 0
Anti = 0
ChickenLittle = 0
Genie = 0
Stich = 0
PeterPan = 0

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
				ConsolePrint("Drive Costs (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Drive Costs (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Drive Costs (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
DriveCosts = ReadLong(0x2A15C68)+0x0, true
WriteByte(DriveCosts+0x144, Valor, true) ---  Valor Form Drive Cost
WriteByte(DriveCosts+0x174, Wisdom, true) ---  Wisdom Form Drive Cost
WriteByte(DriveCosts+0x7794, Limit, true) --- Limit Form Drive Cost
WriteByte(DriveCosts+0x204, Master, true) ---  Master Form Drive Cost
WriteByte(DriveCosts+0x234, Final, true) ---  Final Form Drive Cost
WriteByte(DriveCosts+0x264, Anti, true) ---  Anti Form Drive Cost

WriteByte(DriveCosts+0x61A4, Valor, true) ---  Auto Valor Form Drive Cost
WriteByte(DriveCosts+0x61D4, Wisdom, true) ---  Auto Wisdom Form Drive Cost
WriteByte(DriveCosts+0x77C4, Limit, true) ---  Auto Limit Form Drive Cost
WriteByte(DriveCosts+0x6204, Master, true) ---  Auto Master Form Drive Cost
WriteByte(DriveCosts+0x6234, Final, true) ---  Auto Final Form Drive Cost

WriteByte(DriveCosts+0x4EE4, ChickenLittle, true) ---  Chicken Little Drive Cost
WriteByte(DriveCosts+0xDD4, Genie, true) ---  Genie Drive Cost
WriteByte(DriveCosts+0xE04, Stich, true) ---  Stich Drive Cost
WriteByte(DriveCosts+0x3504, PeterPan, true) ---  Peter Pan Drive Cost
			end
			
			if IsSteamGame == 1 then
DriveCosts = ReadLong(0x2A161E8)+0x0, true
WriteByte(DriveCosts+0x144, Valor, true) ---  Valor Form Drive Cost
WriteByte(DriveCosts+0x174, Wisdom, true) ---  Wisdom Form Drive Cost
WriteByte(DriveCosts+0x7794, Limit, true) --- Limit Form Drive Cost
WriteByte(DriveCosts+0x204, Master, true) ---  Master Form Drive Cost
WriteByte(DriveCosts+0x234, Final, true) ---  Final Form Drive Cost
WriteByte(DriveCosts+0x264, Anti, true) ---  Anti Form Drive Cost

WriteByte(DriveCosts+0x61A4, Valor, true) ---  Auto Valor Form Drive Cost
WriteByte(DriveCosts+0x61D4, Wisdom, true) ---  Auto Wisdom Form Drive Cost
WriteByte(DriveCosts+0x77C4, Limit, true) ---  Auto Limit Form Drive Cost
WriteByte(DriveCosts+0x6204, Master, true) ---  Auto Master Form Drive Cost
WriteByte(DriveCosts+0x6234, Final, true) ---  Auto Final Form Drive Cost

WriteByte(DriveCosts+0x4EE4, ChickenLittle, true) ---  Chicken Little Drive Cost
WriteByte(DriveCosts+0xDD4, Genie, true) ---  Genie Drive Cost
WriteByte(DriveCosts+0xE04, Stich, true) ---  Stich Drive Cost
WriteByte(DriveCosts+0x3504, PeterPan, true) ---  Peter Pan Drive Cost
			end
	
			if IsSteamJPGame == 1 then
DriveCosts = ReadLong(0x2A161E8)+0x0, true
WriteByte(DriveCosts+0x144, Valor, true) ---  Valor Form Drive Cost
WriteByte(DriveCosts+0x174, Wisdom, true) ---  Wisdom Form Drive Cost
WriteByte(DriveCosts+0x7794, Limit, true) --- Limit Form Drive Cost
WriteByte(DriveCosts+0x204, Master, true) ---  Master Form Drive Cost
WriteByte(DriveCosts+0x234, Final, true) ---  Final Form Drive Cost
WriteByte(DriveCosts+0x264, Anti, true) ---  Anti Form Drive Cost

WriteByte(DriveCosts+0x61A4, Valor, true) ---  Auto Valor Form Drive Cost
WriteByte(DriveCosts+0x61D4, Wisdom, true) ---  Auto Wisdom Form Drive Cost
WriteByte(DriveCosts+0x77C4, Limit, true) ---  Auto Limit Form Drive Cost
WriteByte(DriveCosts+0x6204, Master, true) ---  Auto Master Form Drive Cost
WriteByte(DriveCosts+0x6234, Final, true) ---  Auto Final Form Drive Cost

WriteByte(DriveCosts+0x4EE4, ChickenLittle, true) ---  Chicken Little Drive Cost
WriteByte(DriveCosts+0xDD4, Genie, true) ---  Genie Drive Cost
WriteByte(DriveCosts+0xE04, Stich, true) ---  Stich Drive Cost
WriteByte(DriveCosts+0x3504, PeterPan, true) ---  Peter Pan Drive Cost
			end
end
