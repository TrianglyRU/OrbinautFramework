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
			switch round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp - 10), floor(PosY + Ysp + 8 * (Angle == 360)), false, true, Layer);
					if  Distance < 0
					{	
						Xsp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
					if  Distance < 0
					{	
						Ysp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp + 10), floor(PosY + Ysp), true, true, Layer)
					if  Distance < 0
					{	
						Xsp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), false, true, Layer)
					if  Distance < 0
					{	
						Ysp    -= Distance;
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
		var Distance = tile_get_distance_h(floor(PosX - 10), floor(PosY), false, true, Layer);
		if  Distance < 0
		{
			PosX -= Distance;
			Xsp   = 0;
		}
	}
	
	// Right wall collision
	if Grounded == true
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision == true and Angle mod 90 == 0) and Inertia > 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp + 10), floor(PosY + Ysp + 8 * (Angle == 360)), true, true, Layer);
					if  Distance < 0
					{	
						Xsp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), false, true, Layer)
					if  Distance < 0
					{	
						Ysp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp - 10), floor(PosY + Ysp), false, true, Layer)
					if  Distance < 0
					{	
						Xsp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), true, true, Layer)
					if  Distance < 0
					{	
						Ysp    += Distance;
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
		var Distance = tile_get_distance_h(floor(PosX + 10), floor(PosY), true, true, Layer);	
		if  Distance < 0
		{
			PosX += Distance;
			Xsp   = 0;
		}
	}
}