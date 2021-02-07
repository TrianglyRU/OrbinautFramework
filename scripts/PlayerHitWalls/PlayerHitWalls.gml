function PlayerHitWalls()
{	
	// Left wall collision
	if Grounded
	{
		if (FloorAngle < 90 or FloorAngle > 270 or Game.ExtensiveWallCollision and FloorAngle mod 90 = 0) and Inertia < 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide with walls based on current angle range, frame ahead
			switch round(FloorAngle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(PlayerX - 10, PlayerY + !FloorAngle * 8, Layer, false, true);
					if  Distance < 0
					{	
						PosX    = PlayerX - Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY + 10, Layer, true, true)
					if  Distance < 0
					{	
						PosY    = PlayerY + Distance;
						Ysp     = 0;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(PlayerX + 10, PlayerY, Layer, true, true)
					if  Distance < 0
					{	
						PosX    = PlayerX + Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY - 10, Layer, false, true)
					if  Distance < 0
					{	
						PosY    = PlayerY - Distance;
						Ysp     = 0;
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
			PosX    -= Distance;
			Xsp      = 0;
			Inertia  = 0;
		}
	}
	
	// Right wall collision
	if Grounded
	{
		if (FloorAngle < 90 or FloorAngle > 270 or Game.ExtensiveWallCollision and FloorAngle mod 90 = 0) and Inertia > 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide with walls based on current angle range, frame ahead
			switch round(FloorAngle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(PlayerX + 10, PlayerY + !FloorAngle * 8, Layer, true, true);
					if  Distance < 0
					{	
						PosX    = PlayerX + Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY - 10, Layer, false, true)
					if  Distance < 0
					{	
						PosY    = PlayerY - Distance;
						Ysp     = 0;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(PlayerX - 10, PlayerY, Layer, false, true)
					if  Distance < 0
					{	
						PosX    = PlayerX - Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY + 10, Layer, true, true)
					if  Distance < 0
					{	
						PosY    = PlayerY + Distance;
						Ysp     = 0;
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
			PosX    += Distance;
			Xsp      = 0;
			Inertia  = 0;
		}
	}
}