function GameDataLoad()
{
	for (var i = 0; i < 4; i++)
	{
		// Load saved game data
		global.SaveData[i] = savedata_load(i);
	}
	global.GameStartTime = date_current_datetime();
	
	// Load config file and generate random seed
	settings_load();
	random_set_seed(randomise());
}