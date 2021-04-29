function ScreenDebugActivate()
{
	// Exit the code if devmode is disabled
	if (!Game.DevMode) exit;
	
	// Activate general debugging
	if Stage.State != ActStateLoading
	{
		if keyboard_check_pressed(ord("Q"))
		{
			DebugToggle = !DebugToggle;
		}
		/*if keyboard_check_pressed(ord("W"))
		{
			DebugSolids = !DebugSolids;
		}
		if keyboard_check_pressed(ord("E"))
		{
			DebugHitboxes = !DebugHitboxes;
		}
		if keyboard_check_pressed(ord("R"))
		{
			DebugSensors = !DebugSensors;
		}
		if keyboard_check_pressed(ord("T"))
		{
			DebugVariables = !DebugVariables;
		}*/
	}
	
	// Check if general debugging is enabled
	if DebugToggle
	{
		// Set draw colour and alpha
		draw_set_alpha(0.35);
		draw_set_colour(c_black);

		// Darken the screen
		draw_rectangle(Screen.RenderX, Screen.RenderY, Screen.RenderX + Screen.Width, Screen.RenderY + Screen.Height, false);
	
		// Set new draw alpha
		draw_set_alpha(1.0);
		
		// Draw player position point
		with Player
		{
			draw_point_colour(floor(PosX),	   floor(PosY),     c_black);
			draw_point_colour(floor(PosX + 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX - 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX),     floor(PosY + 1), c_white);
			draw_point_colour(floor(PosX),     floor(PosY - 1), c_white);
		}
	
		// Draw objects position points
		with Objects 
		{
			draw_point_colour(floor(x),	    floor(y),     c_black);
			draw_point_colour(floor(x + 1), floor(y),	  c_white);
			draw_point_colour(floor(x - 1), floor(y),	  c_white);
			draw_point_colour(floor(x),     floor(y + 1), c_white);
			draw_point_colour(floor(x),     floor(y - 1), c_white);
		}
	}
	
	// Restore draw colour and alpha
	draw_set_alpha(1.0);
	draw_set_colour(c_white);
}