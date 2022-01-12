function InterfaceDebugSolidboxDraw()
{
	// Exit the code if disabled
	if !DebugSolids
	{
		exit;
	}
	draw_set_alpha(0.5);
	
	with all
	{
		// Draw player's solidbox
		if object_index == Player
		{
			var pTop    = floor(PosY - RadiusY);
			var pLeft   = floor(PosX - 10);
			var pRight  = floor(PosX + 10);
			var pBottom = floor(PosY + RadiusY);
			
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
		}
			
		// Draw object's solidbox
		else if variable_instance_exists(id, "Obj_SolidX")
		{	
			if Obj_SolidMap == false
			{
				draw_rectangle_colour(x - Obj_SolidX, y - Obj_SolidY, x + Obj_SolidX - 1, y + Obj_SolidY - 1, $00ffff, $00ffff, $00ffff, $00ffff, false);
			}
			else
			{
				// Draw sloped
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