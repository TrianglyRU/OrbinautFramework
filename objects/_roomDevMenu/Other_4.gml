/// @description Data & Font
// You can write your code in this editor
	
	// Load data
	data_load(0);
	data_load(1);
	data_load(2);
	data_load(3);
	
	gamesettings_load();
	
	application_set_size(Game.ResolutionWidth, Game.ResolutionHeight);
	window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
	window_set_fullscreen(Game.WindowFullscreen);
	
	// Set font
	draw_set_font(Game.Font[FontMenu]);