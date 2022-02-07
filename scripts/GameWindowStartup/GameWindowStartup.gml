function GameWindowStartup()
{	
	// Set window properties
	var Width  = Game.Width  * Game.WindowSize;
	var Height = Game.Height * Game.WindowSize;	
	
	window_set_size(Width, Height);
	window_set_position((display_get_width() - Width) / 2, (display_get_height() - Height) / 2);
	window_set_fullscreen(Game.FullscreenMode);
	window_set_caption(Game.WindowTitle);
	
	// ...and apply some GPU magic that will increase game speed!
	surface_depth_disable(true);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	
	// Show alert about incorrect Game.Width
	if (Game.Width / 2) mod 2 or (Game.Height / 2) mod 2 != 0
	{
		show_message("Halved game width or height isn't an even number. You may experience some issues because of that!");
	}
}