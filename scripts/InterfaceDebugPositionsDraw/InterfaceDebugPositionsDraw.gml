function InterfaceDebugPositionsDraw()
{
	// Exit if not allowed to toggle
	if !Game.DevMode or !Stage.DoUpdate
	{
		exit;
	}
	
	// Toggle positions
	if keyboard_check_pressed(ord("Q"))
	{
		DebugPositions = !DebugPositions;
	}
	
	// Display position points
	if DebugPositions then with all
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
		
		// Object position (ignore tails object because... well, there is no reason to draw their position)
		else if object_index != TailsObject
		{		
			draw_point_colour(floor(x),	    floor(y),     c_black);
			draw_point_colour(floor(x + 1), floor(y),	  c_white);
			draw_point_colour(floor(x - 1), floor(y),	  c_white);
			draw_point_colour(floor(x),     floor(y + 1), c_white);
			draw_point_colour(floor(x),     floor(y - 1), c_white);
		}
	}
}