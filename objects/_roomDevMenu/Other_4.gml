/// @description Data & Font
// You can write your code in this editor
	
	// Load data	
	for (var i = 0; i < 4; i++)
	{
		SaveslotData[i] = gamedata_load(i);
	}
	
	// Load gamesettings
	gamesettings_load();
	
	// Set window size
	application_set_size(Game.ResolutionWidth, Game.ResolutionHeight);
	window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
	window_set_fullscreen(Game.WindowFullscreen);
	
	// Set font
	draw_set_font(Game.Font[FontMenu]);