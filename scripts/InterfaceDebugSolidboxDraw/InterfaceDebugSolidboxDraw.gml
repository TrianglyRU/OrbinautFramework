function ScreenDebugSolidboxDraw()
{
	// Exit the code if devmode is disabled
	if !Game.DevMode
	{
		exit;
	}
	
	// Activate solidbox debugging
	if Stage.DoUpdate and keyboard_check_pressed(ord("W"))
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
				var pTop    = floor(PosY - RadiusY);
				var pLeft   = floor(PosX - 10);
				var pRight  = floor(PosX + 10);
				var pBottom = floor(PosY + RadiusY);
				draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
			}
			else if variable_instance_exists(id, "Obj_SolidStatus")
			{	
				if Obj_SolidMap == false
				{
					draw_rectangle_colour(x - Obj_SolidX, y - Obj_SolidY, x + Obj_SolidX - 1, y + Obj_SolidY - 1, $00ffff, $00ffff, $00ffff, $00ffff, false);
				}
				else
				{
					for (var i = 0; i < array_length(Obj_SolidMap); i++)
					{
						var HeightAbove = image_xscale ? i : array_length(Obj_SolidMap) - 1 - i;
						var HeightBelow = image_xscale ? array_length(Obj_SolidMap) - 1 - i : i;
						draw_line_colour(x - Obj_SolidX + i, y + Obj_SolidY + Obj_SolidMap[HeightBelow] - 1, x - Obj_SolidX + i, y + Obj_SolidY - Obj_SolidMap[HeightAbove] - 1, $00ffff, $00ffff);
					}
				}
			}
		}
		draw_set_alpha(1.0);
	}
}