function ScreenDebugViewDisplay()
{
	#region Inputs
	{
		if Stage.State != ActStateLoading
		{
			if keyboard_check_pressed(ord("Q"))
			{
				DebugToggle = !DebugToggle;
			}
			if keyboard_check_pressed(ord("W"))
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
			}
		}
	}
	#endregion
		
	if DebugToggle
	{
		// Darken the screen
		draw_set_alpha(0.35);
		draw_rectangle_colour(Screen.RenderX, Screen.RenderY, Screen.RenderX + Screen.Width, Screen.RenderY + Screen.Height, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		
		// Draw solidboxes
		if DebugSolids
		{
			// Draw player's solidbox
			var pLeft   = floor(Player.PosX - 10);
			var pRight  = floor(Player.PosX + 10);
			var pTop    = floor(Player.PosY - Player.yRadius);
			var pBottom = floor(Player.PosY + Player.yRadius);
			draw_set_alpha(0.5);
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
			
			// Draw object solidboxes
			with Objects if variable_instance_exists(id, "objXRadiusSolid")
			{		
				draw_set_alpha(0.5);
				draw_set_colour(variable_instance_exists(id, "isCollidable") and isCollidable == true ? $00ff00 : $00ffff);
				if !variable_instance_exists(id, "hasArrayMap") or variable_instance_exists(id, "hasArrayMap") and hasArrayMap == false
				{
					draw_rectangle(x - objXRadiusSolid, y - objYRadiusSolid, x + objXRadiusSolid - 1, y + objYRadiusSolid - 1, false);
				}
				else
				{
					for (var i = 0; i < objXRadiusSolid * 2; i++)
					{
						var arrayX = floor(x - objXRadiusSolid + i);
						var basicY = image_yscale == 1 ? floor(y + objYRadiusSolid) : floor(y - objYRadiusSolid);
						if image_xscale == 1
						{
							var arrayY = image_yscale == 1 ? floor(y - hasArrayMap[i]) : floor(y + hasArrayMap[i]);
						}
						else if image_xscale == -1
						{
							var arrayY = image_yscale == 1 ? floor(y - hasArrayMap[objXRadiusSolid * 2 - i]) : floor(y + hasArrayMap[objXRadiusSolid * 2 - i]);
						}
						draw_line(arrayX, arrayY, arrayX, basicY);
					}
				}
				
				// Display line to show actual x diameter
				if variable_instance_exists(id, "isCollidable") and isCollidable == true
				{
					draw_set_alpha(0.8);
					if objType == SolidAll and Player.OnObject == id
					{
						draw_line_colour(x - objXRadiusSolid - 11, y - objYRadiusSolid - 20, x + objXRadiusSolid + 9, y - objYRadiusSolid - 20, $00ff00, $00ff00);
					}
					else
					{
						draw_line_colour(x - objXRadiusSolid - 1, y - objYRadiusSolid - 20, x + objXRadiusSolid - 1, y - objYRadiusSolid - 20, $00ff00, $00ff00);
					}
				}
			}
			draw_set_colour($ffffff);
		}
		
		// Draw hitboxes
		if DebugHitboxes
		{
			// Draw player's hitbox
			if Player.Animation == AnimCrouch or Player.Animation == AnimSpindash
			{
				var pTop    = floor(Player.PosY + 2);
				var pLeft   = floor(Player.PosX - 8);
				var pRight  = floor(Player.PosX + 8);
				var pBottom = floor(Player.PosY + 22);	
			}
			else
			{
				var pLeft   = floor(Player.PosX - 8);
				var pRight  = floor(Player.PosX + 8);			     
				var pTop	= floor(Player.PosY - Player.yRadius + 3);
				var pBottom = floor(Player.PosY + Player.yRadius - 3);
			}
			draw_set_alpha(0.5);
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
			
			// Draw object hitboxes
			with Objects if variable_instance_exists(id, "objXRadiusHit")
			{
				draw_set_alpha(0.5);
				draw_rectangle_colour(x - objXRadiusHit, y - objYRadiusHit, x + objXRadiusHit - 1, y + objYRadiusHit - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);		
			}
		}
		
		// Draw triggers
		with Objects if variable_instance_exists(id, "objXRadiusTriggerLeft")
		{
			draw_set_alpha(0.5);
			draw_rectangle_colour(x + objXRadiusTriggerLeft, y + objYRadiusTriggerTop, x + objXRadiusTriggerRight - 1, y + objYRadiusTriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
		}
		draw_set_alpha(1);
		
		// Draw player collision sensor points
		#region Player Collision
		{
			if DebugSensors
			{
				draw_set_colour($00ff00);
				if Player.Grounded
				{
					if !Player.OnObject
					{
						switch Player.AngleRange
						{
							case RangeFloor:
							{
								draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY + Player.yRadius));							
								draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY + Player.yRadius));
								if Player.Inertia == 0
								{
									draw_point(floor(Player.PosX), floor(Player.PosY + Player.yRadius));
								}
							}
							break;
							case RangeRWall:
							{
								draw_point(floor(Player.PosX + Player.yRadius), floor(Player.PosY + Player.xRadius));
								draw_point(floor(Player.PosX + Player.yRadius), floor(Player.PosY - Player.xRadius));
							}
							break;
							case RangeRoof:
							{
								draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY - Player.yRadius));
								draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY - Player.yRadius));
							}
							break;
							case RangeLWall:
							{
								draw_point(floor(Player.PosX - Player.yRadius), floor(Player.PosY + Player.xRadius));
								draw_point(floor(Player.PosX - Player.yRadius), floor(Player.PosY - Player.xRadius));
							}
							break;
						}
					}
					
					draw_set_colour($ff00ff);
					if (Player.Angle < 90 or Player.Angle > 270 or Game.ExtensiveWallCollision and Player.Angle mod 90 == 0)
					{	
						if Player.Inertia < 0
						{
							switch Player.AngleRange
							{
								case RangeFloor:
								{
									draw_point(floor(Player.PosX + Player.Xsp - 10), floor(Player.PosY + Player.Ysp + 8 * (Player.Angle == 360)));
								}
								break;
								case RangeRWall:
								{
									draw_point(floor(Player.PosX + Player.Xsp), floor(Player.PosY + Player.Ysp + 10));
								}
								break;
								case RangeRoof:
								{
									draw_point(floor(Player.PosX + Player.Xsp + 10), floor(Player.PosY + Player.Ysp));
								}
								break;
								case RangeLWall:
								{
									draw_point(floor(Player.PosX + Player.Xsp), floor(Player.PosY + Player.Ysp - 10));
								}
								break;
							}
						}
						else if Player.Inertia > 0
						{
							switch Player.AngleRange
							{
								case RangeFloor:
								{
									draw_point(floor(Player.PosX + Player.Xsp + 10), floor(Player.PosY + Player.Ysp + 8 * (Player.Angle == 360)));
								}
								break;
								case RangeRWall:
								{
									draw_point(floor(Player.PosX + Player.Xsp), floor(Player.PosY + Player.Ysp - 10));
								}
								break;
								case RangeRoof:
								{
									draw_point(floor(Player.PosX + Player.Xsp - 10), floor(Player.PosY + Player.Ysp));
								}
								break;
								case RangeLWall:
								{
									draw_point(floor(Player.PosX + Player.Xsp), floor(Player.PosY + Player.Ysp + 10));
								}
								break;
							}
						}
					}
				}
				else
				{
					draw_set_colour($00ff00);
					if Player.Ysp > 0 or abs(Player.Xsp) > abs(Player.Ysp)
					{
						draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY + Player.yRadius));
						draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY + Player.yRadius));
					}
					draw_set_colour($ffff00);
					if Player.Ysp < 0 or abs(Player.Xsp) > abs(Player.Ysp)
					{
						draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY - Player.yRadius));
						draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY - Player.yRadius));
					}
					draw_set_colour($ff00ff);
					if !(Player.Xsp > abs(Player.Ysp))
					{
						draw_point(floor(Player.PosX - 10), floor(Player.PosY));
					}
					if !(-Player.Xsp > abs(Player.Ysp))
					{
						draw_point(floor(Player.PosX + 10), floor(Player.PosY));
					}
				}
			}
		}
		#endregion
		draw_set_colour($ffffff);
		
		// Draw centre point
		with Objects 
		{
			draw_point_colour(floor(x),     floor(y),     c_black);
			draw_point_colour(floor(x + 1), floor(y),     c_white);
			draw_point_colour(floor(x - 1), floor(y),	  c_white);
			draw_point_colour(floor(x),     floor(y + 1), c_white);
			draw_point_colour(floor(x),     floor(y - 1), c_white);
		}
		with Player
		{
			draw_point_colour(floor(PosX),     floor(PosY),     c_black);
			draw_point_colour(floor(PosX + 1), floor(PosY),     c_white);
			draw_point_colour(floor(PosX - 1), floor(PosY),	    c_white);
			draw_point_colour(floor(PosX),     floor(PosY + 1), c_white);
			draw_point_colour(floor(PosX),     floor(PosY - 1), c_white);
		}
	}
}