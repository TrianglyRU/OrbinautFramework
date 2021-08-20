function InterfaceDebugPositionsDraw()
{
	// Exit if not allowed to display
	if !Game.DevMode or !Stage.DoUpdate or !DebugToggle
	{
		exit;
	}
	
	// Display position points
	with all
	{
		// Player position
		if object_index == Player
		{
			draw_point_colour(floor(PosX),	   floor(PosY),     c_black);
			draw_point_colour(floor(PosX + 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX - 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX),     floor(PosY + 1), c_white);
			draw_point_colour(floor(PosX),     floor(PosY - 1), c_white);
		}
		
		// Object position
		else
		{		
			draw_point_colour(floor(x),	    floor(y),     c_black);
			draw_point_colour(floor(x + 1), floor(y),	  c_white);
			draw_point_colour(floor(x - 1), floor(y),	  c_white);
			draw_point_colour(floor(x),     floor(y + 1), c_white);
			draw_point_colour(floor(x),     floor(y - 1), c_white);
		}
	}
}