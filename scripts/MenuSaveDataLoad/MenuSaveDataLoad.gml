function MenuSaveDataLoad()
{
	for (var i = 0; i < 4; i++)
	{
		// If empty, display as "new game" slot
		if Game.SaveData[i] == 0
		{
			DisplayData[i] = "SAVE " + string(i + 1) + " - NEW GAME";
		}
		
		// If has data, setup it to display
		else
		{
			// Local variables
			var DataCharacter, DataZone, DataEmeralds, DataLives, DataConts, GameCleared;
			
			// Define character
			switch Game.SaveData[i][0]
			{
				case 0:
					DataCharacter = "S";
				break;
				case 1:
					DataCharacter = "T";
				break;
				case 2:
					DataCharacter = "K";
				break;
				default:
					DataCharacter = "UNK";
				break;
			}
			
			// Define zone
			switch Game.SaveData[i][1]
			{
				default:
					DataZone = "TSZ";
				break;
			}
			
			// Define emeralds, lives and conts amount
			DataEmeralds = Game.SaveData[i][2];
			DataLives    = Game.SaveData[i][3];
			DataConts    = Game.SaveData[i][4];
			GameCleared  = Game.SaveData[i][5];

			// Set display info
			if !GameCleared
			{
				DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " " + string(DataZone) + " L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
			}
			else
			{
				DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " DONE " + "L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
			}
		}
	}
}