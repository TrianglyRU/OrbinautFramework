function ScreenDebugViewDisplay()
{
	// Display only if allowed to
	if DebugViewEnabled
	{
		// Draw solidboxes
		if DebugShowSolidboxes
		{
			// Draw player's solidbox
			var pLeft   = floor(Player.PosX - 10);
			var pRight  = floor(Player.PosX + 10);
			var pTop    = floor(Player.PosY - Player.yRadius);
			var pBottom = floor(Player.PosY + Player.yRadius);
			draw_set_alpha(0.5);
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
			draw_set_alpha(1.0);
			
			// Draw object solidboxes
			with Objects
			{	
				if variable_instance_exists(id, "objXRadiusSolid")
				{
					draw_set_alpha(0.5);
					draw_rectangle_colour(x - objXRadiusSolid, y - objYRadiusSolid, x + objXRadiusSolid - 1, y + objYRadiusSolid - 1, $00ffff, $00ffff, $00ffff, $00ffff, false);
					draw_set_alpha(1.0);
					draw_point(x, y);
				}
			}
		}
		
		// Draw hitboxes
		if DebugShowHitboxes
		{
			// Draw player's hitbox
			var pLeft   = floor(Player.PosX - 8);
			var pRight  = floor(Player.PosX + 8);			     
			var pTop	= floor(Player.PosY - Player.yRadius + 3);
			var pBottom = floor(Player.PosY + Player.yRadius - 3);
			draw_set_alpha(0.5);
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
			draw_set_alpha(1.0);
			
			// Draw object hitboxes
			with Objects
			{	
				if variable_instance_exists(id, "objXRadiusHit")
				{
					draw_set_alpha(0.5);
					draw_rectangle_colour(x - objXRadiusHit, y - objYRadiusHit, x + objXRadiusHit - 1, y + objYRadiusHit - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
					
				}
				if variable_instance_exists(id, "objXRadiusTriggerLeft")
				{
					draw_set_alpha(0.5);
					draw_rectangle_colour(x + objXRadiusTriggerLeft, y + objYRadiusTriggerTop, x + objXRadiusTriggerRight - 1, y + objYRadiusTriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
				}
				draw_set_alpha(1.0);
				draw_point(x, y);
			}
		}
		
		// Draw player collision sensor points
		#region Player Collision
		{
			if Player.Grounded
			{
				switch Player.AngleRange
				{
					case RangeFloor:
					{
						draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY + Player.yRadius));
						draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY + Player.yRadius));
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
			
				if (Player.Angle < 90 or Player.Angle > 270 or Game.ExtensiveWallCollision and Player.Angle mod 90 = 0)
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
				if Player.Ysp > 0 or abs(Player.Xsp) > abs(Player.Ysp)
				{
					draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY + Player.yRadius));
					draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY + Player.yRadius));
				}
				if Player.Ysp < 0 or abs(Player.Xsp) > abs(Player.Ysp)
				{
					draw_point(floor(Player.PosX - Player.xRadius), floor(Player.PosY - Player.yRadius));
					draw_point(floor(Player.PosX + Player.xRadius), floor(Player.PosY - Player.yRadius));
				}
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
		#endregion
		
		// Draw centre point
		draw_point(floor(Player.PosX), floor(Player.PosY));
	}
	else
	{
		DebugShowHitboxes   = false;
		DebugShowSolidboxes = false;
	}
	
	// Show tile collision
	layer_set_visible(layer_get_id("CollisionTilesA"), DebugViewEnabled and DebugShowCollision and Player.Layer == LayerA);
	layer_set_visible(layer_get_id("CollisionTilesB"), DebugViewEnabled and DebugShowCollision and Player.Layer == LayerB);
		
	// Restore default transparency
	draw_set_alpha(1);
}