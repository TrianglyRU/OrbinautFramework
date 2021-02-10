function PlayerHitWalls()
{	
	// Use different wall radiuses. Originals don't do this, but we want to improve stability, so here we go!
	var WallRadius = Rolling or Jumping ? 8 : 10;
	
	// Left wall collision
	if Grounded
	{
		if (FloorAngle < 90 or FloorAngle > 270 or Game.ExtensiveWallCollision and FloorAngle mod 90 = 0) and Inertia < 0
		{
			// Get position
			var PlayerX = PosX + Xsp;
			var PlayerY = PosY + Ysp;
			
			// Collide with walls based on current angle range, frame ahead
			switch round(FloorAngle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(PlayerX - WallRadius, PlayerY + !FloorAngle * 8, Layer, false, true);
					if  Distance < 0
					{	
						RealPosX = PlayerX - Distance;
						Xsp      = 0;
						Inertia  = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY + WallRadius, Layer, true, true)
					if  Distance < 0
					{	
						RealPosY = PlayerY + Distance;
						Ysp      = 0;
						Inertia  = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(PlayerX + WallRadius, PlayerY, Layer, true, true)
					if  Distance < 0
					{	
						RealPosX = PlayerX + Distance;
						Xsp      = 0;
						Inertia  = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY - WallRadius, Layer, false, true)
					if  Distance < 0
					{	
						RealPosY = PlayerY - Distance;
						Ysp      = 0;
						Inertia  = 0;
					}
				}
				break;
			}
		}
	}
	else if !(Xsp > abs(Ysp))
	{
		// Collide airborne at the current frame
		var Distance = tile_get_distance_h(PosX - WallRadius, PosY, Layer, false, true);
		if  Distance < 0
		{
			RealPosX -= Distance;
			Xsp       = 0;
			Inertia   = 0;
		}
	}
	
	// Right wall collision
	if Grounded
	{
		if (FloorAngle < 90 or FloorAngle > 270 or Game.ExtensiveWallCollision and FloorAngle mod 90 = 0) and Inertia > 0
		{
			// Get position
			var PlayerX = PosX + Xsp;
			var PlayerY = PosY + Ysp;
			
			// Collide with walls based on current angle range, frame ahead
			switch round(FloorAngle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(PlayerX + WallRadius, PlayerY + !FloorAngle * 8, Layer, true, true);
					if  Distance < 0
					{	
						RealPosX = PlayerX + Distance;
						Xsp      = 0;
						Inertia  = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY - WallRadius, Layer, false, true)
					if  Distance < 0
					{	
						RealPosY = PlayerY - Distance;
						Ysp      = 0;
						Inertia  = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(PlayerX - WallRadius, PlayerY, Layer, false, true)
					if  Distance < 0
					{	
						RealPosX = PlayerX - Distance;
						Xsp      = 0;
						Inertia  = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY + WallRadius, Layer, true, true)
					if  Distance < 0
					{	
						RealPosY = PlayerY + Distance;
						Ysp      = 0;
						Inertia  = 0;
					}
				}
				break;
			}
		}
	}
	else if !(-Xsp > abs(Ysp))
	{	
		// Collide airborne at the current frame
		var Distance = tile_get_distance_h(PosX + WallRadius, PosY, Layer, true, true);	
		if  Distance < 0
		{
			RealPosX += Distance;
			Xsp       = 0;
			Inertia   = 0;
		}
	}
}