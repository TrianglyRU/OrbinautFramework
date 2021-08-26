function GameDataLoad()
{
	// Load game settings
	gamesettings_load("config");
	
	// Load random seed
	random_set_seed(randomise());
}