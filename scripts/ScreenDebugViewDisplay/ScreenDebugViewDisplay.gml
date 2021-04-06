function ScreenDebugViewDisplay()
{
	// Display only if allowed to
	if DebugViewEnabled = true
	{
		// Draw player's solidbox
		var PlayerLeft   = floor(Player.PosX - 10);
		var PlayerRight  = floor(Player.PosX + 10);
		var PlayerTop    = floor(Player.PosY - Player.yRadius);
		var PlayerBottom = floor(Player.PosY + Player.yRadius);
		draw_set_alpha(0.5);
		draw_rectangle_colour(PlayerLeft, PlayerTop, PlayerRight, PlayerBottom, $41d5ff, $41d5ff, $41d5ff, $41d5ff, false);
	
		// Draw player's hitbox
		var HitboxLeft   = floor(Player.PosX - 8);
		var HitboxRight  = floor(Player.PosX + 8);			     
		var HitboxTop	 = floor(Player.PosY - Player.yRadius + 3);
		var HitboxBottom = floor(Player.PosY + Player.yRadius - 3);
		if DebugShowHitboxes
		{
			draw_set_alpha(0.5);
			draw_rectangle_colour(HitboxLeft, HitboxTop, HitboxRight, HitboxBottom, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
			draw_set_alpha(1);
			draw_point(floor(Player.PosX), floor(Player.PosY));
		}
	
		// Draw hitboxes
		if DebugShowHitboxes
		{			
			with Objects
			{	
				if variable_instance_exists(id, "objXRadiusHit")
				{
					draw_set_alpha(0.5);
					draw_rectangle_colour(x - objXRadiusHit, y - objYRadiusHit, x + objXRadiusHit - 1, y + objYRadiusHit - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
					draw_set_alpha(1);
					draw_point(x, y);
				}
			}
			
		}
		
		// Draw player collision points
		draw_set_alpha(1);
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
		
		// Show collision
		layer_set_visible(layer_get_id("CollisionTilesA"), DebugShowCollision and Player.Layer == LayerA);
		layer_set_visible(layer_get_id("CollisionTilesB"), DebugShowCollision and Player.Layer == LayerB);
	}
	else
	{
		//layer_set_visible(layer_get_id("CollisionTilesA"), false);
		//layer_set_visible(layer_get_id("CollisionTilesB"), false);
	}
		
	// Restore default transparency
	draw_set_alpha(1);
}