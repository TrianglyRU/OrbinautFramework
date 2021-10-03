function GameDataLoad()
{
	// Load saved data
	for (var i = 0; i < 4; i++)
	{
		Game.SaveData[i] = gamedata_load(i);
	}
	
	// Load game settings
	gamesettings_load("config");
	
	// Load random seed
	random_set_seed(randomise());
}