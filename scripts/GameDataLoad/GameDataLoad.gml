function GameDataLoad()
{
	// Load (or create) config file
	gamesettings_load("config");
	
	// Load saved data
	for (var i = 0; i < 4; i++)
	{
		Game.SaveData[i] = gamedata_load(i);
	}

	// Generate random seed
	random_set_seed(randomise());
}