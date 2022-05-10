/// @description Draw Debug Data
// You can write your code in this editor
	
	#region Draw Solidboxes
	{
		if DebugSolids
		{
			draw_set_alpha(0.5);
			with all
			{
				// Draw player's solidbox
				if object_index == Player
				{
					var WRadius = DefaultRadiusX + 1;
					
					var pTop    = floor(PosY - RadiusY);
					var pLeft   = floor(PosX - WRadius);
					var pRight  = floor(PosX + WRadius);
					var pBottom = floor(PosY + RadiusY);
			
					draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
				}
			
				// Draw object's solidbox
				else
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
	}
	#endregion
	
	#region Draw Hitboxes
	{
		if DebugHitboxes
		{
			draw_set_alpha(0.5);
			with all
			{			
				// Draw player's hitbox
				if object_index == Player and !DebugMode
				{
					if DoubleSpinAttack
					{
						draw_rectangle_colour(HitboxData[1][0], HitboxData[1][1], HitboxData[1][2], HitboxData[1][3], $00ff00, $00ff00, $00ff00, $00ff00, false);
					}
					draw_rectangle_colour(HitboxData[0][0], HitboxData[0][1], HitboxData[0][2], HitboxData[0][3], $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);	
				}
			
				// Draw object's hitbox
				else
				{
					draw_rectangle_colour(x - Obj_HitX, y - Obj_HitY, x + Obj_HitX - 1, y + Obj_HitY - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
				}			
			}
			draw_set_alpha(1.0);
		}
	}
	#endregion
	
	#region Draw Triggers
	{
		if DebugTriggers
		{
			// Draw triggers
			draw_set_alpha(0.5);
			with all
			{
				draw_rectangle_colour(x + Obj_TriggerLeft, y + Obj_TriggerTop, x + Obj_TriggerRight - 1, y + Obj_TriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
			}
			draw_set_alpha(1.0);
		}
	}
	#endregion
	
	#region Draw Positions
	{
		if DebugPositions
		{
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
	}
	#endregion