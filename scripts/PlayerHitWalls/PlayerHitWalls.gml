function PlayerHitWalls()
{	
	// Left wall collision
	if Grounded
	{
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 = 0) and Inertia < 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide with walls based on current angle range, frame ahead
			switch round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					if !Game.TileCollisionMethod
					{
						var Distance = colmask_get_distance_h(PlayerX - 10, PlayerY + !Angle * 8, false, true);
					}
					else
					{
						var Distance = tile_get_distance_h(PlayerX - 10, PlayerY + !Angle * 8, Layer, false, true);
					}
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
					var Distance = colmask_get_distance_v(PlayerX, PlayerY + 10, true, true)
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
					var Distance = colmask_get_distance_h(PlayerX + 10, PlayerY, true, true)
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
					var Distance = colmask_get_distance_v(PlayerX, PlayerY - 10, false, true)
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
		if !Game.TileCollisionMethod
		{
			var Distance = colmask_get_distance_h(floor(PosX - 10), floor(PosY), false, true);
		}
		else
		{
			var Distance = tile_get_distance_h(floor(PosX - 10), floor(PosY), Layer, false, true);
		}
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
		if (Angle < 90 or Angle > 270 or Game.ExtensiveWallCollision and Angle mod 90 = 0) and Inertia > 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide with walls based on current angle range, frame ahead
			switch round(Angle/90) % 4
			{
				case RangeFloor:
				{	
					if !Game.TileCollisionMethod
					{
						var Distance = colmask_get_distance_h(PlayerX + 10, PlayerY + !Angle * 8, true, true);
					}
					else
					{
						var Distance = tile_get_distance_h(PlayerX + 10, PlayerY + !Angle * 8, Layer, true, true);
					}
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
					var Distance = colmask_get_distance_v(PlayerX, PlayerY - 10, false, true)
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
					var Distance = colmask_get_distance_h(PlayerX - 10, PlayerY, false, true)
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
					var Distance = colmask_get_distance_v(PlayerX, PlayerY + 10, true, true)
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
		if !Game.TileCollisionMethod
		{
			var Distance = colmask_get_distance_h(floor(PosX + 10), floor(PosY), true, true);
		}
		else
		{
			var Distance = tile_get_distance_h(floor(PosX + 10), floor(PosY), Layer, true, true);
		}		
		if  Distance < 0
		{
			PosX    += Distance;
			Xsp      = 0;
			Inertia  = 0;
		}
	}
}