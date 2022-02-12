function MenuSaveDataLoad()
{
	for (var i = 0; i < 4; i++)
	{
		// If empty, display as "new game" slot
		if global.SaveData[i] == 0
		{
			DisplayData[i] = "SAVE " + string(i + 1) + " - NEW GAME";
		}
		
		// If has data, setup stuff
		else
		{
			switch global.SaveData[i][0]
			{
				case 0:
					var DataCharacter = "S";
				break;
				case 1:
					var DataCharacter = "T";
				break;
				case 2:
					var DataCharacter = "K";
				break;
				default:
					var DataCharacter = "UNK";
				break;
			}
			var DataZone     = global.SaveData[i][1];
			var DataEmeralds = global.SaveData[i][2];
			var DataLives    = global.SaveData[i][3];
			var DataConts    = global.SaveData[i][4];
			var GameCleared  = global.SaveData[i][5];

			// Set information to display
			if !GameCleared
			{
				DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " ZONE " + string(DataZone) + " - " + "L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
			}
			else
			{
				DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " CLEAR " + " - " + "L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
			}
		}
	}
}