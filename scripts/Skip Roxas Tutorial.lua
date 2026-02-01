LUAGUI_NAME = "Skip Roxas Tutorial"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Skip Roxas Tutorial"

LevelUpTable = 2
championsBelt = true;
medal = true;
powerBoost = true;
defenseBoost = true;
magicBoost = true;
apBoost = true;
apBoostCount = 2;

--- Game Version Check
epiccheck = 0x585B61
stmcheck = epiccheck+0x2F8
stmjpcheck = epiccheck+0x2A8

--- Epic Games
EpicWorld = 0x716DF8
EpicRoom = 0x716DFC
EpicEvent = 0x716E00
EpicChampionBelt = 0x9AC933
EpicMedal = 0x9AC8E0
EpicSoraPowerBoostGiven = 0x9AB829
EpicSoraMagicBoostGiven = 0x9AB82A
EpicSoraDefenseBoostGiven = 0x9AB82B
EpicSoraAPBoostGiven = 0x9AB828
EpicTable = 0x9AB830
EpicMenuTutorial1 = 0x9AB7C8
EpicMenuTutorial2 = 0x2A2301C
EpicMenuTutorial3 = 0x9AB013
EpicMenuTutorial4 = 0x2A23018
EpicMenuTutorial5 = 0x9AD5A0
EpicTwilightTownFlag1 = 0x9AB003
EpicTwilightTownFlag2 = 0x9AB6CE
EpicTwilightTownFlag3 = 0x9ACA30
EpicTwilightTownFlag4 = 0x9AB874
EpicTwilightTownFlag5 = 0x9AB000
EpicTwilightTownFlag6 = 0x9ACA38
EpicTwilightTownFlag7 = 0x9ACA3A
EpicTwilightTownFlag8 = 0x9ACA3D
EpicTwilightTownFlag9 = 0x9ACA18
EpicTwilightTownMap = 0x9AC9F7
EpicMansionMap = 0x9AC9F9

--- Steam
SteamWorld = EpicWorld+0x210
SteamRoom = EpicRoom+0x210
SteamEvent = EpicEvent+0x210
SteamChampionBelt = EpicChampionBelt+0x580
SteamMedal = EpicMedal+0x580
SteamSoraPowerBoostGiven = EpicSoraPowerBoostGiven+0x580
SteamSoraMagicBoostGiven = EpicSoraMagicBoostGiven+0x580
SteamSoraDefenseBoostGiven = EpicSoraDefenseBoostGiven+0x580
SteamSoraAPBoostGiven = EpicSoraAPBoostGiven+0x580
SteamTable = 0x9ABDB0
SteamMenuTutorial1 = EpicMenuTutorial1+0x580
SteamMenuTutorial2 = EpicMenuTutorial2+0x580
SteamMenuTutorial3 = EpicMenuTutorial3+0x580
SteamMenuTutorial4 = EpicMenuTutorial4+0x580
SteamMenuTutorial5 = EpicMenuTutorial5+0x580
SteamTwilightTownFlag1 = EpicTwilightTownFlag1+0x580
SteamTwilightTownFlag2 = EpicTwilightTownFlag2+0x580
SteamTwilightTownFlag3 = EpicTwilightTownFlag3+0x580
SteamTwilightTownFlag4 = EpicTwilightTownFlag4+0x580
SteamTwilightTownFlag5 = EpicTwilightTownFlag5+0x580
SteamTwilightTownFlag6 = EpicTwilightTownFlag6+0x580
SteamTwilightTownFlag7 = EpicTwilightTownFlag7+0x580
SteamTwilightTownFlag8 = EpicTwilightTownFlag8+0x580
SteamTwilightTownFlag9 = EpicTwilightTownFlag9+0x580
SteamTwilightTownMap = EpicTwilightTownMap+0x580
SteamMansionMap = EpicMansionMap+0x580

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
				ConsolePrint("Skip Roxas Tutorial (EPIC GL) - installed")
			end
			
			if ReadLong(stmcheck) == 0x7265737563697065 and IsSteamGame == 0 then
				IsSteamGame = 1
				ConsolePrint("Skip Roxas Tutorial (Steam GL) - installed")
			end
			
			if ReadLong(stmjpcheck) == 0x7265737563697065 and IsSteamJPGame == 0 then
				IsSteamJPGame = 1
				ConsolePrint("Skip Roxas Tutorial (Steam JP) - installed")
			end
		
			if IsEpicGame == 1 then
if ReadByte(EpicTwilightTownFlag1) == 0 then
				if ReadInt(EpicWorld) == 0x00000102 and ReadInt(EpicRoom) == 0x00380038 then
					WriteInt(EpicWorld, 0x001702)
					WriteByte(EpicRoom, 0x02)
					WriteByte(EpicEvent, 0x02)
					WriteByte(EpicTwilightTownFlag2, 0x9F)
					WriteByte(EpicTwilightTownFlag3, 0x04)
					WriteArray(EpicTwilightTownFlag4, {0x89, 0x01, 0x88, 0x01, 0xA5, 0x01, 0x94, 0x01, 0x97, 0x01, 0x97, 0x01, 0x95, 0x01, 0x9E, 0x00, 0x52, 0x00, 0x8A, 0x00})
					WriteArray(EpicTwilightTownFlag5, {0x01, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xDB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0x05, 0x08, 0x01, 0x00, 0x00, 0x81})
					WriteByte(EpicTwilightTownFlag6, 0x06)
					WriteByte(EpicTwilightTownFlag7, 0x40)
					WriteByte(EpicTwilightTownFlag8, 0x02)
					WriteByte(EpicTwilightTownFlag9, 0x01)
					WriteByte(EpicTwilightTownMap, 0x80)
					WriteByte(EpicMansionMap, 0x80)
					WriteByte(EpicTable, LevelUpTable)
					
						if championsBelt == true then
							WriteInt(EpicChampionBelt, 0x01)				
						end
						if medal == true then
							WriteInt(EpicMedal, 0x01)
						end
						if powerBoost == true then
							currentPowerBoost = ReadByte(EpicSoraPowerBoostGiven)
							WriteByte(EpicSoraPowerBoostGiven, currentPowerBoost + 1)
						end
						if defenseBoost == true then
							currentDefenseBoost = ReadByte(EpicSoraDefenseBoostGiven)
							WriteByte(EpicSoraDefenseBoostGiven, currentDefenseBoost + 1)
						end
						if magicBoost == true then
							currentMagicBoost = ReadByte(EpicSoraMagicBoostGiven)
							WriteByte(EpicSoraMagicBoostGiven, currentMagicBoost + 1)
						end
						
					if apBoost == true and apBoostCount > 0 then
						WriteInt(EpicSoraAPBoostGiven, ReadByte(EpicSoraAPBoostGiven)+apBoostCount);
					end
				end
				
			if ReadByte(EpicMenuTutorial1) == 3 and ReadByte(EpicMenuTutorial2) == 20 and ReadByte(EpicMenuTutorial3) == 0 then
				WriteByte(EpicMenuTutorial4, 24)
				WriteByte(EpicMenuTutorial2, 24)
			elseif ReadByte(EpicMenuTutorial1) < 3 and ReadByte(EpicMenuTutorial2) == 20 and ReadByte(EpicMenuTutorial3) == 0  then
				WriteByte(EpicMenuTutorial4, 30)
				WriteByte(EpicMenuTutorial2, 30)
			end

			if ReadByte(EpicMenuTutorial5) == 0x00 then
				WriteByte(EpicMenuTutorial5, 0x33)
			end
			end
			end
			
			if IsSteamGame == 1 then
if ReadByte(SteamTwilightTownFlag1) == 0 then
				if ReadInt(SteamWorld) == 0x00000102 and ReadInt(SteamRoom) == 0x00380038 then
					WriteInt(SteamWorld, 0x001702)
					WriteByte(SteamRoom, 0x02)
					WriteByte(SteamEvent, 0x02)
					WriteByte(SteamTwilightTownFlag2, 0x9F)
					WriteByte(SteamTwilightTownFlag3, 0x04)
					WriteArray(SteamTwilightTownFlag4, {0x89, 0x01, 0x88, 0x01, 0xA5, 0x01, 0x94, 0x01, 0x97, 0x01, 0x97, 0x01, 0x95, 0x01, 0x9E, 0x00, 0x52, 0x00, 0x8A, 0x00})
					WriteArray(SteamTwilightTownFlag5, {0x01, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xDB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0x05, 0x08, 0x01, 0x00, 0x00, 0x81})
					WriteByte(SteamTwilightTownFlag6, 0x06)
					WriteByte(SteamTwilightTownFlag7, 0x40)
					WriteByte(SteamTwilightTownFlag8, 0x02)
					WriteByte(SteamTwilightTownFlag9, 0x01)
					WriteByte(SteamTwilightTownMap, 0x80)
					WriteByte(SteamMansionMap, 0x80)
					WriteByte(SteamTable, LevelUpTable)
					
						if championsBelt == true then
							WriteInt(SteamChampionBelt, 0x01)				
						end
						if medal == true then
							WriteInt(SteamMedal, 0x01)
						end
						if powerBoost == true then
							currentPowerBoost = ReadByte(SteamSoraPowerBoostGiven)
							WriteByte(SteamSoraPowerBoostGiven, currentPowerBoost + 1)
						end
						if defenseBoost == true then
							currentDefenseBoost = ReadByte(SteamSoraDefenseBoostGiven)
							WriteByte(SteamSoraDefenseBoostGiven, currentDefenseBoost + 1)
						end
						if magicBoost == true then
							currentMagicBoost = ReadByte(SteamSoraMagicBoostGiven)
							WriteByte(SteamSoraMagicBoostGiven, currentMagicBoost + 1)
						end
					if apBoost == true and apBoostCount > 0 then
						WriteInt(SteamSoraAPBoostGiven, ReadByte(SteamSoraAPBoostGiven)+apBoostCount);
					end
				end
				
			if ReadByte(SteamMenuTutorial1) == 3 and ReadByte(SteamMenuTutorial2) == 20 and ReadByte(SteamMenuTutorial3) == 0 then
				WriteByte(SteamMenuTutorial4, 24)
				WriteByte(SteamMenuTutorial2, 24)
			elseif ReadByte(SteamMenuTutorial1) < 3 and ReadByte(SteamMenuTutorial2) == 20 and ReadByte(SteamMenuTutorial3) == 0  then
				WriteByte(SteamMenuTutorial4, 30)
				WriteByte(SteamMenuTutorial2, 30)
			end

			if ReadByte(SteamMenuTutorial5) == 0x00 then
				WriteByte(SteamMenuTutorial5, 0x33)
			end
			end
			end
	
			if IsSteamJPGame == 1 then
if ReadByte(SteamTwilightTownFlag1) == 0 then
				if ReadInt(SteamWorld) == 0x00000102 and ReadInt(SteamRoom) == 0x00380038 then
					WriteInt(SteamWorld, 0x001702)
					WriteByte(SteamRoom, 0x02)
					WriteByte(SteamEvent, 0x02)
					WriteByte(SteamTwilightTownFlag2, 0x9F)
					WriteByte(SteamTwilightTownFlag3, 0x04)
					WriteArray(SteamTwilightTownFlag4, {0x89, 0x01, 0x88, 0x01, 0xA5, 0x01, 0x94, 0x01, 0x97, 0x01, 0x97, 0x01, 0x95, 0x01, 0x9E, 0x00, 0x52, 0x00, 0x8A, 0x00})
					WriteArray(SteamTwilightTownFlag5, {0x01, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xDB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0x05, 0x08, 0x01, 0x00, 0x00, 0x81})
					WriteByte(SteamTwilightTownFlag6, 0x06)
					WriteByte(SteamTwilightTownFlag7, 0x40)
					WriteByte(SteamTwilightTownFlag8, 0x02)
					WriteByte(SteamTwilightTownFlag9, 0x01)
					WriteByte(SteamTwilightTownMap, 0x80)
					WriteByte(SteamMansionMap, 0x80)
					WriteByte(SteamTable, LevelUpTable)
					
						if championsBelt == true then
							WriteInt(SteamChampionBelt, 0x01)				
						end
						if medal == true then
							WriteInt(SteamMedal, 0x01)
						end
						if powerBoost == true then
							currentPowerBoost = ReadByte(SteamSoraPowerBoostGiven)
							WriteByte(SteamSoraPowerBoostGiven, currentPowerBoost + 1)
						end
						if defenseBoost == true then
							currentDefenseBoost = ReadByte(SteamSoraDefenseBoostGiven)
							WriteByte(SteamSoraDefenseBoostGiven, currentDefenseBoost + 1)
						end
						if magicBoost == true then
							currentMagicBoost = ReadByte(SteamSoraMagicBoostGiven)
							WriteByte(SteamSoraMagicBoostGiven, currentMagicBoost + 1)
						end
					if apBoost == true and apBoostCount > 0 then
						WriteInt(SteamSoraAPBoostGiven, ReadByte(SteamSoraAPBoostGiven)+apBoostCount);
					end
				end
				
			if ReadByte(SteamMenuTutorial1) == 3 and ReadByte(SteamMenuTutorial2) == 20 and ReadByte(SteamMenuTutorial3) == 0 then
				WriteByte(SteamMenuTutorial4, 24)
				WriteByte(SteamMenuTutorial2, 24)
			elseif ReadByte(SteamMenuTutorial1) < 3 and ReadByte(SteamMenuTutorial2) == 20 and ReadByte(SteamMenuTutorial3) == 0  then
				WriteByte(SteamMenuTutorial4, 30)
				WriteByte(SteamMenuTutorial2, 30)
			end

			if ReadByte(SteamMenuTutorial5) == 0x00 then
				WriteByte(SteamMenuTutorial5, 0x33)
			end
			end
			end
end
