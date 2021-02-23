function ScreenDebugViewDisplay()
{
	// Display only if allowed to
	if EnableDebug = false exit;

	// Draw floor and ceiling player collision points
	if Player.Grounded
	{
		switch round(Player.Angle/90) % 4
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
	}
	
	// Draw wall player collision points
	if Player.Grounded
	{
		if (Player.Angle < 90 or Player.Angle > 270 or Game.ExtensiveWallCollision and Player.Angle mod 90 = 0)
		{	
			// Left
			if Player.Inertia < 0
			{
				switch round(Player.Angle/90) % 4
				{
					case RangeFloor:
					{
						draw_point(floor(Player.PosX + Player.Xsp - 10), floor(Player.PosY + Player.Ysp + !Player.Angle * 8));
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
			
			// Right
			if Player.Inertia > 0
			{
				switch round(Player.Angle/90) % 4
				{
					case RangeFloor:
					{
						draw_point(floor(Player.PosX + Player.Xsp + 10), floor(Player.PosY + Player.Ysp + !Player.Angle * 8));
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
		if !(Player.Xsp > abs(Player.Ysp))
		{
			draw_point(floor(Player.PosX - 10), floor(Player.PosY));
		}
		if !(-Player.Xsp > abs(Player.Ysp))
		{
			draw_point(floor(Player.PosX + 10), floor(Player.PosY));
		}
	}
	
	draw_set_alpha(0.65);
		
	// Draw player's solidbox
	/*var PlayerLeft   = floor(Player.PosX - 10);
	var PlayerRight  = floor(Player.PosX + 10);
	var PlayerTop    = floor(Player.PosY - Player.yRadius);
	var PlayerBottom = floor(Player.PosY + Player.yRadius);
	draw_rectangle(PlayerLeft, PlayerTop, PlayerRight, PlayerBottom, false);*/
	
	// Draw player's hitbox
	var HitboxLeft   = floor(Player.PosX - 8);
	var HitboxRight  = floor(Player.PosX + 8);			     
	var HitboxTop	 = floor(Player.PosY - Player.yRadius + 3);
	var HitboxBottom = floor(Player.PosY + Player.yRadius - 3);
	draw_rectangle_colour(HitboxLeft, HitboxTop, HitboxRight, HitboxBottom, c_purple, c_purple, c_purple, c_purple, false);
	
	// Draw object hitboxes
	with Objects
	{
		draw_rectangle_colour(bbox_left, bbox_top, bbox_right, bbox_bottom, c_purple, c_purple, c_purple, c_purple, false);
	}
}