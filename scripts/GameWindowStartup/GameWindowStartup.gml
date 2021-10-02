function GameWindowStartup()
{	
	// Get our game resolution and its multiplier
	var Width  = Game.Width  * Game.WindowSize;
	var Height = Game.Height * Game.WindowSize;
	
	// Set window properties
	window_set_size(Width, Height);
	window_set_position((display_get_width() - Width) / 2, (display_get_height() - Height) / 2 - 48);
	window_set_fullscreen(Game.WindowFullscreen);
	
	// Enable surface draw
	application_surface_draw_enable(true);
}