function GameWindowSetup()
{	
	// Get our game resolution and its multiplier
	var Width  = Game.ResolutionWidth  * Game.WindowSize;
	var Height = Game.ResolutionHeight * Game.WindowSize;
	
	// Set window size
	window_set_size(Width, Height);
	window_set_position((display_get_width() - Width) / 2, (display_get_height() - Height) / 2);
	
	// Go fullscreen if it is enabled
	window_set_fullscreen(Game.WindowFullscreen);	
}