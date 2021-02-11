function PlayerHitWalls()
{	
	// Use different wall radiuses. Originals don't do this, but we want to improve stability, so here we go!
	var WallRadius = Rolling or Jumping ? 8 : 10;
	
	// Left wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 = 0) and Inertia < 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide with walls based on current angle range, frame ahead
			switch AngleRange//round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(PlayerX - WallRadius, PlayerY + !Angle * 8, Layer, false, true);
					if  Distance < 0
					{	
						Xsp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY + WallRadius, Layer, true, true)
					if  Distance < 0
					{	
						Ysp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(PlayerX + WallRadius, PlayerY, Layer, true, true)
					if  Distance < 0
					{	
						Xsp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY - WallRadius, Layer, false, true)
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
		var Distance = tile_get_distance_h(floor(PosX) - WallRadius, floor(PosY), Layer, false, true);
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
			// Get position
			var PlayerX = floor(PosX) + floor(Xsp);
			var PlayerY = floor(PosY) + floor(Ysp);
			
			// Collide with walls based on current angle range, frame ahead
			switch AngleRange//round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					var Distance = tile_get_distance_h(PlayerX + WallRadius, PlayerY + !Angle * 8, Layer, true, true);
					if  Distance < 0
					{	
						Xsp    += Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY - WallRadius, Layer, false, true)
					if  Distance < 0
					{	
						Ysp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeRoof:
				{	
					var Distance = tile_get_distance_h(PlayerX - WallRadius, PlayerY, Layer, false, true)
					if  Distance < 0
					{	
						Xsp    -= Distance;
						Inertia = 0;
					}
				}
				break;
				case RangeLWall:
				{
					var Distance = tile_get_distance_v(PlayerX, PlayerY + WallRadius, Layer, true, true)
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
		var Distance = tile_get_distance_h(floor(PosX) + WallRadius, floor(PosY), Layer, true, true);	
		if  Distance < 0
		{
			PosX	+= Distance;
			Xsp      = 0;
			Inertia  = 0;
		}
	}
}