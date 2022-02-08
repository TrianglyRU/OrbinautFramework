function InterfaceDebugPositionsDraw()
{
	if !DebugPositions
	{
		return;
	}
	
	with all
	{
		// Draw player's position
		if object_index == Player
		{
			draw_point_colour(floor(PosX),	   floor(PosY),     c_black);
			draw_point_colour(floor(PosX + 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX - 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX),     floor(PosY + 1), c_white);
			draw_point_colour(floor(PosX),     floor(PosY - 1), c_white);
		}
		
		// Draw object's position
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