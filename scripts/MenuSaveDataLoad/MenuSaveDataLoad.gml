function MenuSaveDataLoad()
{
	for (var i = 0; i < 4; i++)
	{
		// Load data slot
		SaveData[i] = gamedata_load(i);
		
		// If empty, display as "new game" slot
		if SaveData[i] == 0
		{
			DisplayData[i] = "SAVE " + string(i + 1) + " - NEW GAME";
		}
		
		// If has data, setup it to display
		else
		{
			// Local variables
			var DataCharacter, DataZone, DataEmeralds, DataLives, DataConts;
			
			// Define character
			switch SaveData[i][0]
			{
				case 0:
					DataCharacter = "SONIC";
				break;
				case 1:
					DataCharacter = "TAILS";
				break;
				case 2:
					DataCharacter = "KNUCKLES";
				break;
				default:
					DataCharacter = "UNKNOWN";
				break;
			}
			
			// Define zone
			switch SaveData[i][1]
			{
				case 0:
					DataZone = "MQZ";
				break;
				default:
					DataZone = "UNKNOWN";
				break;
			}
			
			// Define emeralds, lives and conts amount
			DataEmeralds = SaveData[i][2];
			DataLives    = SaveData[i][3];
			DataConts    = SaveData[i][4];

			// Set display info
			DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " " + string(DataZone) + " L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
		}
	}
}