function PlayerGroundWallCollision()
{	
	// Exit if collision are disables
	if !AllowCollision
	{
		exit;
	}
	
	// Exit if angle is too steep
	if Angle >= 90 and Angle <= 270
	{
		if !Game.SKWallCollision or Angle mod 90 != 0
		{
			exit;
		}
	}
	
	// Update wall angle quadrant
	if Angle <= 43.59 or Angle >= 316.41			
	{
		var AngleRange = RangeFloor;
	}
	else if Angle >= 45 and Angle <= 135	
	{
		var AngleRange = RangeRWall;
	}
	else if Angle >= 136.41 and Angle <= 223.59
	{
		var AngleRange = RangeRoof;
	}
	else if Angle >= 225 and Angle <= 315	
	{
		var AngleRange = RangeLWall;
	}

	// Left wall collision
	if Inertia < 0
	{
		// Collide with walls based on current angle range, frame ahead
		switch AngleRange
		{
			case RangeFloor:
			{	
				var tileData = tile_check_collision_h(floor(PosX + Xsp - 10), floor(PosY + Ysp + 8 * (Angle == 360)), false, true, Layer);
				if  tileData[0] < 0 
				{	
					// Affect player speeds
					Xsp    -= tileData[0];
					Inertia = 0;
					
					Pushing = true;
				}		
			}
			break;
			case RangeRWall:
			{
				var tileData = tile_check_collision_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
				if  tileData[0] < 0
				{
					// Affect player speeds
					Ysp  += tileData[0];
					Inertia = 0;
				}
			}
			break;
			case RangeRoof:
			{	
				var tileData = tile_check_collision_h(floor(PosX + Xsp + 10), floor(PosY + Ysp), true, true, Layer)
				if  tileData[0] < 0
				{	
					// Affect player speeds
					Xsp    += tileData[0];
					Inertia = 0;
				}
			}
			break;
			case RangeLWall:
			{
				var tileData = tile_check_collision_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), false, true, Layer)
				if  tileData[0] < 0
				{	
					// Affect player speeds
					Ysp    -= tileData[0];
					Inertia = 0;
				}
			}
			break;
		}
	}
	
	// Right wall collision
	else if Inertia > 0
	{
		// Collide with walls based on current angle range, frame ahead
		switch AngleRange
		{
			case RangeFloor:
			{	
				var tileData = tile_check_collision_h(floor(PosX + Xsp + 10), floor(PosY + Ysp + 8 * (Angle == 360)), true, true, Layer);
				if  tileData[0] < 0
				{	
					// Affect player speeds
					Xsp    += tileData[0];
					Inertia = 0;
					
					Pushing = true;
				}
			}
			break;
			case RangeRWall:
			{
				var tileData = tile_check_collision_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), false, true, Layer)
				if  tileData[0] < 0
				{	
					// Affect player speeds
					Ysp    -= tileData[0];
					Inertia = 0;
				}
			}
			break;
			case RangeRoof:
			{	
				var tileData = tile_check_collision_h(floor(PosX + Xsp - 10), floor(PosY + Ysp), false, true, Layer)
				if  tileData[0] < 0
				{	
					// Affect player speeds
					Xsp    -= tileData[0];
					Inertia = 0;
				}
			}
			break;
			case RangeLWall:
			{
				var tileData = tile_check_collision_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
				if  tileData[0] < 0
				{	
					// Affect player speeds
					Ysp    += tileData[0];
					Inertia = 0;
				}
			}
			break;
		}
	}
}