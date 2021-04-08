function PlayerHitWalls()
{	
	// Do not collide if we're not allowed to
	if (!AllowCollision) exit;
	
	// Left wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 == 0) and Inertia < 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch AngleRange
			{
				case RangeFloor:
				{	
					var tileData = tile_check_collision_h(floor(PosX + Xsp - 10), floor(PosY + Ysp + 8 * (Angle == 360)), false, true, Layer);
					if  tileData[0] < 0 
					{	
						Xsp    -= tileData[0];
						Inertia = 0;
						
						// Set flag
						Pushing = DirLeft;
					}
				}
				break;
				case RangeRWall:
				{
					var tileData = tile_check_collision_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
					if  tileData[0] < 0
					{	
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
						Ysp    -= tileData[0];
						Inertia = 0;
					}
				}
				break;
			}
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
	}
	
	// Right wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 == 0) and Inertia > 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch AngleRange
			{
				case RangeFloor:
				{	
					var tileData = tile_check_collision_h(floor(PosX + Xsp + 10), floor(PosY + Ysp + 8 * (Angle == 360)), true, true, Layer);
					if  tileData[0] < 0
					{	
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
						Ysp  += tileData[0];
						
						// We're colling with floor in this case. Update angle and angle range
						Angle      = tileData[1];
						AngleRange = round(Angle/90) % 4;
					}
				}
				break;
			}
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
	}
}