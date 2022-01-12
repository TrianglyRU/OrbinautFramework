function GameWindowStartup()
{	
	// Set window properties
	var Width  = Game.Width  * Game.WindowSize;
	var Height = Game.Height * Game.WindowSize;
	
	window_set_size(Width, Height);
	window_set_position((display_get_width() - Width) / 2, (display_get_height() - Height) / 2);
	window_set_fullscreen(Game.WindowFullscreen);
	window_set_caption(Game.WindowTitle);
	
	// ...and apply some GPU magic that will increase game speed!
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
}