function GameWindowSetup()
{	
	// Get our resolution and its multiplier
	var Width  = Game.ResolutionWidth  * Game.WindowSize;
	var Height = Game.ResolutionHeight * Game.WindowSize;
	
	// Set window size and place it at the centre of our screen
	window_set_size(Width, Height);
	window_set_position((display_get_width() - Width) / 2, (display_get_height() - Height) / 2);
	
	// Apply fullscreen if said to
	window_set_fullscreen(Game.WindowFullscreen);	
}