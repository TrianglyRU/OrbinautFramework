function InterfaceDebugSolidboxDraw()
{
	// Exit if not allowed to display
	if !Game.DevMode or !Stage.DoUpdate
	{
		exit;
	}
	
	// Toggle solidbox debug
	if keyboard_check_pressed(ord("W"))
	{
		DebugSolids = !DebugSolids;
	}
	
	// Display solidboxes
	if DebugSolids
	{
		draw_set_alpha(0.5);
		with all
		{
			// Player solidbox
			if object_index == Player
			{
				var pTop    = floor(PosY - RadiusY);
				var pLeft   = floor(PosX - 10);
				var pRight  = floor(PosX + 10);
				var pBottom = floor(PosY + RadiusY);
				draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
			}
			
			// Object solidbox
			else if variable_instance_exists(id, "Obj_SolidStatus")
			{	
				// Display normal solidbox
				if Obj_SolidMap == false
				{
					draw_rectangle_colour(x - Obj_SolidX, y - Obj_SolidY, x + Obj_SolidX - 1, y + Obj_SolidY - 1, $00ffff, $00ffff, $00ffff, $00ffff, false);
				}
				
				// Display sloped solidbox
				else
				{
					for (var i = 0; i < array_length(Obj_SolidMap); i++)
					{
						var Height = image_xscale ? i : array_length(Obj_SolidMap) - 1 - i;
						
						if image_yscale
						{
							draw_line_colour(x - Obj_SolidX + i, y + Obj_SolidY + (Obj_SolidY * 2 - Obj_SolidMap[Height]) - 1, x - Obj_SolidX + i, y + Obj_SolidY - Obj_SolidMap[Height] - 1, $00ffff, $00ffff);
						}
						else
						{
							draw_line_colour(x - Obj_SolidX + i, y - Obj_SolidY - (Obj_SolidY * 2 - Obj_SolidMap[Height]) - 1, x - Obj_SolidX + i, y - Obj_SolidY + Obj_SolidMap[Height] - 1, $00ffff, $00ffff);
						}
					}
				}
			}
		}
		draw_set_alpha(1.0);
	}
}