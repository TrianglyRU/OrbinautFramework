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
	}
	
	// Check if general debugging is enabled
	if DebugToggle
	{
		// Darken the screen
		//draw_set_alpha(0.35);
		//(Screen.CameraX, Screen.CameraY, Screen.CameraX + Screen.Width, Screen.CameraY + Screen.Height, c_black, c_black, c_black, c_black, false);
		//draw_set_alpha(1.0);
		
		// Draw position points
		with all
		{
			if object_index == Player
			{
				draw_point_colour(floor(PosX),	   floor(PosY),     c_black);
				draw_point_colour(floor(PosX + 1), floor(PosY),	    c_white);
				draw_point_colour(floor(PosX - 1), floor(PosY),	    c_white);
				draw_point_colour(floor(PosX),     floor(PosY + 1), c_white);
				draw_point_colour(floor(PosX),     floor(PosY - 1), c_white);
			}
			else
			{
				if variable_instance_exists(id, "objXRadiusTriggerLeft")
				{
					draw_set_alpha(0.35);
					draw_rectangle_colour(x - objXRadiusTriggerLeft, y - objYRadiusTriggerTop, x + objXRadiusTriggerRight - 1, y + objYRadiusTriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
					draw_set_alpha(1.0);
				}
				draw_point_colour(floor(x),	    floor(y),     c_black);
				draw_point_colour(floor(x + 1), floor(y),	  c_white);
				draw_point_colour(floor(x - 1), floor(y),	  c_white);
				draw_point_colour(floor(x),     floor(y + 1), c_white);
				draw_point_colour(floor(x),     floor(y - 1), c_white);
			}
		}
	}
}