function GameDataLoad()
{
	// If first startup, initialise data
	if !directory_exists(Game.FolderName)
	{
		// Create game folder
		directory_create(Game.FolderName);
		
		// Save game settings
		gamesettings_save("config");
		
		// Set empty save data
		Game.SaveData = [0, 0, 0, 0];
	}
	
	// If not, load it
	else
	{
		// Load game settings
		gamesettings_load("config");
		
		// Load saved data
		for (var i = 0; i < 4; i++)
		{
			Game.SaveData[i] = gamedata_load(i);
		}
	}

	// Generate random seed
	random_set_seed(randomise());
}