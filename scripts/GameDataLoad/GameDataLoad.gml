function GameDataLoad()
{
	// Load saved game data
	for (var i = 0; i < 4; i++)
	{
		Game.SaveData[i] = gamedata_load(i);
	}
	
	// Load config file and generate random seed
	gamesettings_load("config");
	random_set_seed(randomise());
}