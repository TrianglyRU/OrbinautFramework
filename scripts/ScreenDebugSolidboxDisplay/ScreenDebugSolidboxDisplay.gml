function ScreenDebugSolidboxDisplay()
{
	// Exit the code if devmode is disabled
	if !Game.DevMode
	{
		exit;
	}
	
	// Activate solidbox debugging
	if Stage.State != ActStateLoading and keyboard_check_pressed(ord("W"))
	{
		DebugSolids = !DebugSolids;
	}

	// Check if general and solidbox debugging is enabled
	if DebugToggle and DebugSolids
	{
		// Draw solidboxes
		draw_set_alpha(0.5);
		with all
		{
			if object_index == Player
			{
				var pTop    = floor(PosY - yRadius);
				var pLeft   = floor(PosX - 10);
				var pRight  = floor(PosX + 10);
				var pBottom = floor(PosY + yRadius);
				draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
			}
			else if variable_instance_exists(id, "objXRadiusSolid")
			{	
				draw_rectangle_colour(x - objXRadiusSolid, y - objYRadiusSolid, x + objXRadiusSolid - 1, y + objYRadiusSolid - 1, $00ffff, $00ffff, $00ffff, $00ffff, false);	
			}
		}
		draw_set_alpha(1.0);
	}
}