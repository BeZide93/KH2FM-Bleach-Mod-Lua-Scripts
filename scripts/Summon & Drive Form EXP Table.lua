LUAGUI_NAME = "Summon & Drive Form EXP Table"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Summon & Drive Form EXP Table"

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
				ConsolePrint("Summon & Drive Form EXP Table (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Summon & Drive Form EXP Table (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Summon & Drive Form EXP Table (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
EXPTable = ReadLong(0x2AE5188)+0x0,true
SummonLV1 = EXPTable+0xC, true
SummonLV2 = EXPTable+0x14, true
SummonLV3 = EXPTable+0x1C, true
SummonLV4 = EXPTable+0x24, true
SummonLV5 = EXPTable+0x2C, true
SummonLV6 = EXPTable+0x34, true
ValorLV1 = EXPTable+0x44, true
ValorLV2 = EXPTable+0x4C, true
ValorLV3 = EXPTable+0x54, true
ValorLV4 = EXPTable+0x5C, true
ValorLV5 = EXPTable+0x64, true
ValorLV6 = EXPTable+0x6C, true
WisdomLV1 = EXPTable+0x7C, true
WisdomLV2 = EXPTable+0x84, true
WisdomLV3 = EXPTable+0x8C, true
WisdomLV4 = EXPTable+0x94, true
WisdomLV5 = EXPTable+0x9C, true
WisdomLV6 = EXPTable+0xA4, true
LimitLV1 = EXPTable+0xB4, true
LimitLV2 = EXPTable+0xBC, true
LimitLV3 = EXPTable+0xC4, true
LimitLV4 = EXPTable+0xCC, true
LimitLV5 = EXPTable+0xD4, true
LimitLV6 = EXPTable+0xDC, true
MasterLV1 = EXPTable+0xEC, true
MasterLV2 = EXPTable+0xF4, true
MasterLV3 = EXPTable+0xFC, true
MasterLV4 = EXPTable+0x104, true
MasterLV5 = EXPTable+0x10C, true
MasterLV6 = EXPTable+0x114, true
FinalLV1 = EXPTable+0x124, true
FinalLV2 = EXPTable+0x12C, true
FinalLV3 = EXPTable+0x134, true
FinalLV4 = EXPTable+0x13C, true
FinalLV5 = EXPTable+0x144, true
FinalLV6 = EXPTable+0x14C, true
WriteInt(SummonLV1, 1, true)
WriteInt(SummonLV2, 1, true)
WriteInt(SummonLV3, 1, true)
WriteInt(SummonLV4, 1, true)
WriteInt(SummonLV5, 1, true)
WriteInt(SummonLV6, 1, true)
WriteInt(ValorLV1, 1, true)
WriteInt(ValorLV2, 1, true)
WriteInt(ValorLV3, 1, true)
WriteInt(ValorLV4, 1, true)
WriteInt(ValorLV5, 1, true)
WriteInt(ValorLV6, 1, true)
WriteInt(WisdomLV1, 1, true)
WriteInt(WisdomLV2, 1, true)
WriteInt(WisdomLV3, 1, true)
WriteInt(WisdomLV4, 1, true)
WriteInt(WisdomLV5, 1, true)
WriteInt(WisdomLV6, 1, true)
WriteInt(LimitLV1, 1, true)
WriteInt(LimitLV2, 1, true)
WriteInt(LimitLV3, 1, true)
WriteInt(LimitLV4, 1, true)
WriteInt(LimitLV5, 1, true)
WriteInt(LimitLV6, 1, true)
WriteInt(MasterLV1, 1, true)
WriteInt(MasterLV2, 1, true)
WriteInt(MasterLV3, 1, true)
WriteInt(MasterLV4, 1, true)
WriteInt(MasterLV5, 1, true)
WriteInt(MasterLV6, 1, true)
WriteInt(FinalLV1, 1, true)
WriteInt(FinalLV2, 1, true)
WriteInt(FinalLV3, 1, true)
WriteInt(FinalLV4, 1, true)
WriteInt(FinalLV5, 1, true)
WriteInt(FinalLV6, 1, true)
			end
			
			if IsSteamGame == 1 then
EXPTable = ReadLong(0x2AE5708)+0x0,true
SummonLV1 = EXPTable+0xC, true
SummonLV2 = EXPTable+0x14, true
SummonLV3 = EXPTable+0x1C, true
SummonLV4 = EXPTable+0x24, true
SummonLV5 = EXPTable+0x2C, true
SummonLV6 = EXPTable+0x34, true
ValorLV1 = EXPTable+0x44, true
ValorLV2 = EXPTable+0x4C, true
ValorLV3 = EXPTable+0x54, true
ValorLV4 = EXPTable+0x5C, true
ValorLV5 = EXPTable+0x64, true
ValorLV6 = EXPTable+0x6C, true
WisdomLV1 = EXPTable+0x7C, true
WisdomLV2 = EXPTable+0x84, true
WisdomLV3 = EXPTable+0x8C, true
WisdomLV4 = EXPTable+0x94, true
WisdomLV5 = EXPTable+0x9C, true
WisdomLV6 = EXPTable+0xA4, true
LimitLV1 = EXPTable+0xB4, true
LimitLV2 = EXPTable+0xBC, true
LimitLV3 = EXPTable+0xC4, true
LimitLV4 = EXPTable+0xCC, true
LimitLV5 = EXPTable+0xD4, true
LimitLV6 = EXPTable+0xDC, true
MasterLV1 = EXPTable+0xEC, true
MasterLV2 = EXPTable+0xF4, true
MasterLV3 = EXPTable+0xFC, true
MasterLV4 = EXPTable+0x104, true
MasterLV5 = EXPTable+0x10C, true
MasterLV6 = EXPTable+0x114, true
FinalLV1 = EXPTable+0x124, true
FinalLV2 = EXPTable+0x12C, true
FinalLV3 = EXPTable+0x134, true
FinalLV4 = EXPTable+0x13C, true
FinalLV5 = EXPTable+0x144, true
FinalLV6 = EXPTable+0x14C, true
WriteInt(SummonLV1, 1, true)
WriteInt(SummonLV2, 1, true)
WriteInt(SummonLV3, 1, true)
WriteInt(SummonLV4, 1, true)
WriteInt(SummonLV5, 1, true)
WriteInt(SummonLV6, 1, true)
WriteInt(ValorLV1, 1, true)
WriteInt(ValorLV2, 1, true)
WriteInt(ValorLV3, 1, true)
WriteInt(ValorLV4, 1, true)
WriteInt(ValorLV5, 1, true)
WriteInt(ValorLV6, 1, true)
WriteInt(WisdomLV1, 1, true)
WriteInt(WisdomLV2, 1, true)
WriteInt(WisdomLV3, 1, true)
WriteInt(WisdomLV4, 1, true)
WriteInt(WisdomLV5, 1, true)
WriteInt(WisdomLV6, 1, true)
WriteInt(LimitLV1, 1, true)
WriteInt(LimitLV2, 1, true)
WriteInt(LimitLV3, 1, true)
WriteInt(LimitLV4, 1, true)
WriteInt(LimitLV5, 1, true)
WriteInt(LimitLV6, 1, true)
WriteInt(MasterLV1, 1, true)
WriteInt(MasterLV2, 1, true)
WriteInt(MasterLV3, 1, true)
WriteInt(MasterLV4, 1, true)
WriteInt(MasterLV5, 1, true)
WriteInt(MasterLV6, 1, true)
WriteInt(FinalLV1, 1, true)
WriteInt(FinalLV2, 1, true)
WriteInt(FinalLV3, 1, true)
WriteInt(FinalLV4, 1, true)
WriteInt(FinalLV5, 1, true)
WriteInt(FinalLV6, 1, true)
			end
	
			if IsSteamJPGame == 1 then
EXPTable = ReadLong(0x2AE5708)+0x0,true
SummonLV1 = EXPTable+0xC, true
SummonLV2 = EXPTable+0x14, true
SummonLV3 = EXPTable+0x1C, true
SummonLV4 = EXPTable+0x24, true
SummonLV5 = EXPTable+0x2C, true
SummonLV6 = EXPTable+0x34, true
ValorLV1 = EXPTable+0x44, true
ValorLV2 = EXPTable+0x4C, true
ValorLV3 = EXPTable+0x54, true
ValorLV4 = EXPTable+0x5C, true
ValorLV5 = EXPTable+0x64, true
ValorLV6 = EXPTable+0x6C, true
WisdomLV1 = EXPTable+0x7C, true
WisdomLV2 = EXPTable+0x84, true
WisdomLV3 = EXPTable+0x8C, true
WisdomLV4 = EXPTable+0x94, true
WisdomLV5 = EXPTable+0x9C, true
WisdomLV6 = EXPTable+0xA4, true
LimitLV1 = EXPTable+0xB4, true
LimitLV2 = EXPTable+0xBC, true
LimitLV3 = EXPTable+0xC4, true
LimitLV4 = EXPTable+0xCC, true
LimitLV5 = EXPTable+0xD4, true
LimitLV6 = EXPTable+0xDC, true
MasterLV1 = EXPTable+0xEC, true
MasterLV2 = EXPTable+0xF4, true
MasterLV3 = EXPTable+0xFC, true
MasterLV4 = EXPTable+0x104, true
MasterLV5 = EXPTable+0x10C, true
MasterLV6 = EXPTable+0x114, true
FinalLV1 = EXPTable+0x124, true
FinalLV2 = EXPTable+0x12C, true
FinalLV3 = EXPTable+0x134, true
FinalLV4 = EXPTable+0x13C, true
FinalLV5 = EXPTable+0x144, true
FinalLV6 = EXPTable+0x14C, true
WriteInt(SummonLV1, 1, true)
WriteInt(SummonLV2, 1, true)
WriteInt(SummonLV3, 1, true)
WriteInt(SummonLV4, 1, true)
WriteInt(SummonLV5, 1, true)
WriteInt(SummonLV6, 1, true)
WriteInt(ValorLV1, 1, true)
WriteInt(ValorLV2, 1, true)
WriteInt(ValorLV3, 1, true)
WriteInt(ValorLV4, 1, true)
WriteInt(ValorLV5, 1, true)
WriteInt(ValorLV6, 1, true)
WriteInt(WisdomLV1, 1, true)
WriteInt(WisdomLV2, 1, true)
WriteInt(WisdomLV3, 1, true)
WriteInt(WisdomLV4, 1, true)
WriteInt(WisdomLV5, 1, true)
WriteInt(WisdomLV6, 1, true)
WriteInt(LimitLV1, 1, true)
WriteInt(LimitLV2, 1, true)
WriteInt(LimitLV3, 1, true)
WriteInt(LimitLV4, 1, true)
WriteInt(LimitLV5, 1, true)
WriteInt(LimitLV6, 1, true)
WriteInt(MasterLV1, 1, true)
WriteInt(MasterLV2, 1, true)
WriteInt(MasterLV3, 1, true)
WriteInt(MasterLV4, 1, true)
WriteInt(MasterLV5, 1, true)
WriteInt(MasterLV6, 1, true)
WriteInt(FinalLV1, 1, true)
WriteInt(FinalLV2, 1, true)
WriteInt(FinalLV3, 1, true)
WriteInt(FinalLV4, 1, true)
WriteInt(FinalLV5, 1, true)
WriteInt(FinalLV6, 1, true)
			end
end
