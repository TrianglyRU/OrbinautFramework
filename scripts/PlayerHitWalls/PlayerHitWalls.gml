function PlayerHitWalls()
{	
	// Do not collide if we're not allowed to
	if (!AllowCollision) exit;
	
	// Define wall range
	if Angle >= 0 and Angle <= 44 or Angle >= 314 and Angle <= 360
	{
		 var WallRange = RangeFloor;
	}
	if Angle >= 45 and Angle <= 134
	{
		var WallRange = RangeRWall;
	}
	if Angle >= 135 and Angle <= 224
	{
		var WallRange = RangeRoof;
	}
	if Angle >= 225 and Angle <= 313
	{
		var WallRange = RangeLWall;
	}
	
	// Left wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 == 0) and Inertia < 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch WallRange
			{
				case RangeFloor:
				{	
					var tileData = tile_check_collision_h(floor(PosX + Xsp - 10), floor(PosY + Ysp + 8 * (Angle == 360)), false, true, Layer);
					if  tileData[0] < 0 
					{	
						// Affect player speeds
						Xsp    -= tileData[0];
						Inertia = 0;
						
						// Set flag
						Pushing = DirLeft;
					}		
					
					DebugValue[80] = floor(PosX + Xsp - 10);
					DebugValue[81] = floor(PosY + Ysp + 8 * (Angle == 360));
				}
				break;
				case RangeRWall:
				{
					var tileData = tile_check_collision_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
					if  tileData[0] < 0
					{
						// Affect player speeds
						Ysp  += tileData[0];
						
						// We're colling with floor in this case. Update angle and angle range
						Angle      = tileData[1];
						AngleRange = round(Angle/90) % 4;
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
			
			// Store distance to display in debug
			Screen.DebugValue[5] = tileData[0];
		}
	}
	else if !(Xsp > abs(Ysp))
	{		
		// Collide airborne at the current frame
		var tileData = tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer);
		if  tileData[0] < 0
		{
			PosX -= tileData[0];
			Xsp   = 0;
		}
		
		// Store distance to display in debug
		Screen.DebugValue[5] = tileData[0];
	}
	
	// Right wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Angle == 45 or Angle == 315 or Game.ExtensiveWallCollision and Angle mod 90 == 0) and Inertia > 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch WallRange
			{
				case RangeFloor:
				{	
					var tileData = tile_check_collision_h(floor(PosX + Xsp + 10), floor(PosY + Ysp + 8 * (Angle == 360)), true, true, Layer);
					if  tileData[0] < 0
					{	
						// Affect player speeds
						Xsp    += tileData[0];
						Inertia = 0;
						
						// Set flag
						Pushing = DirRight;
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
						Ysp += tileData[0];
						
						// We're colling with floor in this case. Update angle and angle range
						Angle      = tileData[1];
						AngleRange = round(Angle/90) % 4;
					}
				}
				break;
			}
			
			// Store distance to display in debug
			Screen.DebugValue[6] = tileData[0];
		}
	}
	else if !(-Xsp > abs(Ysp))
	{	
		// Collide airborne at the current frame
		var tileData = tile_check_collision_h(floor(PosX + 10), floor(PosY), true, true, Layer);	
		if  tileData[0] < 0
		{
			PosX += tileData[0];
			Xsp   = 0;
		}
		
		// Store distance to display in debug
		Screen.DebugValue[6] = tileData[0];
	}
}