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
			
			// Collide if distance is negative (frame ahead)
			switch round(Angle/90) % 4
			{
				case PositionFloor:
				{	
					var Distance = colmask_get_distance_h(PlayerX - 10, PlayerY + !Angle * 8, false, 0)
					if  Distance < 0
					{	
						PosX    = PlayerX - Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case PositionRightwall:
				{
					var Distance = colmask_get_distance_v(PlayerX, PlayerY + 10, true, 0)
					if  Distance < 0
					{	
						PosY    = PlayerY + Distance;
						Ysp     = 0;
						Inertia = 0;
					}
				}
				break;
				case PositionRoof:
				{	
					var Distance = colmask_get_distance_h(PlayerX + 10, PlayerY, true, 0)
					if  Distance < 0
					{	
						PosX    = PlayerX + Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case PositionLeftwall:
				{
					var Distance = colmask_get_distance_v(PlayerX, PlayerY - 10, false, 0)
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
		var Distance = colmask_get_distance_h(floor(PosX - 10), floor(PosY), false, 0)
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
			
			// Collide if distance is negative (frame ahead)
			switch round(Angle/90) % 4
			{
				case PositionFloor:
				{	
					var Distance = colmask_get_distance_h(PlayerX + 10, PlayerY + !Angle * 8, true, 0)
					if  Distance < 0
					{	
						PosX    = PlayerX + Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case PositionRightwall:
				{
					var Distance = colmask_get_distance_v(PlayerX, PlayerY - 10, false, 0)
					if  Distance < 0
					{	
						PosY    = PlayerY - Distance;
						Ysp     = 0;
						Inertia = 0;
					}
				}
				break;
				case PositionRoof:
				{	
					var Distance = colmask_get_distance_h(PlayerX - 10, PlayerY, false, 0)
					if  Distance < 0
					{	
						PosX    = PlayerX - Distance;
						Xsp     = 0;
						Inertia = 0;
					}
				}
				break;
				case PositionLeftwall:
				{
					var Distance = colmask_get_distance_v(PlayerX, PlayerY + 10, true, 0)
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
		var Distance = colmask_get_distance_h(floor(PosX + 10), floor(PosY), true, 0)
		if  Distance < 0
		{
			PosX    += Distance;
			Xsp      = 0;
			Inertia  = 0;
		}
	}
}