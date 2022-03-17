function GameWindowStartup()
{	
	// Alert about incorrect global.Width
	if (global.Width / 2) mod 2 or (global.Height / 2) mod 2 != 0
	{
		show_message("UNSUPPORTED RESOLUTION! \nHalved width or height isn't an even value. You may experience some issues because of that");
	}
	
	// Update application and camera size to game resolution
	application_set_size(global.Width, global.Height);
	
	// Set window properties
	var Width  = global.Width  * global.WindowSize;
	var Height = global.Height * global.WindowSize;	
	
	window_set_position( (display_get_width() - Width) / 2, (display_get_height() - Height) / 2 );
	window_set_size(Width, Height);
	
	window_set_fullscreen(global.StartFullscreen);
	window_set_caption(global.WindowTitle);
	
	// ...and apply some GPU magic that will increase game speed!
	surface_depth_disable(true);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
}