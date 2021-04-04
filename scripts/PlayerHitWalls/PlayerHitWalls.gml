function PlayerHitWalls()
{	
	// Do not collide if we're not allowed to
	if (AllowCollision == false) exit;
	
	// Left wall collision
	if Grounded == true
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision == true and Angle mod 90 == 0) and Inertia < 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch AngleRange
			{
				case RangeFloor:
				{	
					var floorDistance = tile_get_distance_h(floor(PosX + Xsp - 10), floor(PosY + Ysp + 8 * (Angle == 360)), false, true, Layer);
					if  floorDistance < 0
					{	
						Xsp    -= floorDistance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var floorDistance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
					if  floorDistance < 0
					{	
						Ysp    += floorDistance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var floorDistance = tile_get_distance_h(floor(PosX + Xsp + 10), floor(PosY + Ysp), true, true, Layer)
					if  floorDistance < 0
					{	
						Xsp    += floorDistance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var floorDistance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), false, true, Layer)
					if  floorDistance < 0
					{	
						Ysp    -= floorDistance;
						Inertia = 0;
					}
				}
				break;
			}
		}
	}
	else if (Xsp > abs(Ysp)) == false
	{
		// Collide airborne at the current frame
		var floorDistance = tile_get_distance_h(floor(PosX - 10), floor(PosY), false, true, Layer);
		if  floorDistance < 0
		{
			PosX -= floorDistance;
			Xsp   = 0;
		}
	}
	
	// Right wall collision
	if Grounded == true
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision == true and Angle mod 90 == 0) and Inertia > 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch AngleRange
			{
				case RangeFloor:
				{	
					var floorDistance = tile_get_distance_h(floor(PosX + Xsp + 10), floor(PosY + Ysp + 8 * (Angle == 360)), true, true, Layer);
					if  floorDistance < 0
					{	
						Xsp    += floorDistance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var floorDistance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), false, true, Layer)
					if  floorDistance < 0
					{	
						Ysp    -= floorDistance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var floorDistance = tile_get_distance_h(floor(PosX + Xsp - 10), floor(PosY + Ysp), false, true, Layer)
					if  floorDistance < 0
					{	
						Xsp    -= floorDistance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var floorDistance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
					if  floorDistance < 0
					{	
						Ysp    += floorDistance;
						Inertia = 0;
					}
				}
				break;
			}
		}
	}
	else if (-Xsp > abs(Ysp)) == false
	{	
		// Collide airborne at the current frame
		var floorDistance = tile_get_distance_h(floor(PosX + 10), floor(PosY), true, true, Layer);	
		if  floorDistance < 0
		{
			PosX += floorDistance;
			Xsp   = 0;
		}
	}
}