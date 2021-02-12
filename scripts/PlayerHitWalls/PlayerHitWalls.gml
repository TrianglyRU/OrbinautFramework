function PlayerHitWalls()
{	
	// Left wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 = 0) and Inertia < 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp - 10), floor(PosY + Ysp + !Angle * 8), Layer, false, true);
					if  Distance < 0
					{	
						Xsp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), Layer, true, true)
					if  Distance < 0
					{	
						Ysp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp + 10), floor(PosY + Ysp), Layer, true, true)
					if  Distance < 0
					{	
						Xsp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), Layer, false, true)
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
	else if !(Xsp > abs(Ysp))
	{
		// Collide airborne at the current frame
		var Distance = tile_get_distance_h(floor(PosX - 10), floor(PosY), Layer, false, true);
		if  Distance < 0
		{
			PosX   -= Distance;
			Xsp     = 0;
			Inertia = 0;
		}
	}
	
	// Right wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 = 0) and Inertia > 0
		{
			// Collide with walls based on current angle range, frame ahead
			switch round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp + 10), floor(PosY + Ysp + !Angle * 8), Layer, true, true);
					if  Distance < 0
					{	
						Xsp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp - 10), Layer, false, true)
					if  Distance < 0
					{	
						Ysp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(floor(PosX + Xsp - 10), floor(PosY + Ysp), Layer, false, true)
					if  Distance < 0
					{	
						Xsp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(floor(PosX + Xsp), floor(PosY + Ysp + 10), Layer, true, true)
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
	else if !(-Xsp > abs(Ysp))
	{	
		// Collide airborne at the current frame
		var Distance = tile_get_distance_h(floor(PosX + 10), floor(PosY), Layer, true, true);	
		if  Distance < 0
		{
			PosX	+= Distance;
			Xsp      = 0;
			Inertia  = 0;
		}
	}
}