function PlayerHitWalls()
{	
	// Update angle mode for wall collision when grounded
	if Grounded
	{
		switch round(Angle/90) % 4
		{
			case ModeFloor:
			{	
				// Set coordinates
				var xLeft  = floor(PosX - xRadius);
				var yLeft  = floor(PosY + yRadius);
				var xRight = floor(PosX + xRadius);
				var yRight = floor(PosY + yRadius);
			
				// Get floor distances
				var dLeft  = colmask_get_distance_v(xLeft, yLeft, true, TileSize)
				var dRight = colmask_get_distance_v(xRight, yRight, true, TileSize)
			
				// Get floor angle
				var Ang = dLeft <= dRight? colmask_get_angle_v(xLeft, yLeft, true) : colmask_get_angle_v(xRight, yRight, true);
			}
			break;
			case ModeWallR:
			{	
				// Set coordinates
				var xLeft  = floor(PosX + yRadius);
				var yLeft  = floor(PosY + xRadius);
				var xRight = floor(PosX + yRadius);
				var yRight = floor(PosY - xRadius);
			
				// Get floor distances
				var dLeft  = colmask_get_distance_h(xLeft, yLeft, true, TileSize)
				var dRight = colmask_get_distance_h(xRight, yRight, true, TileSize)
			
				// Get floor angle
				var Ang = dLeft <= dRight? colmask_get_angle_h(xLeft, yLeft, true) : colmask_get_angle_h(xRight, yRight, true);
			}
			break;
			case ModeRoof:
			{	
				// Set coordinates
				var xLeft  = floor(PosX + xRadius);
				var yLeft  = floor(PosY - yRadius);
				var xRight = floor(PosX - xRadius);
				var yRight = floor(PosY - yRadius);
			
				// Get floor distances and angles
				var dLeft  = colmask_get_distance_v(xLeft, yLeft, false, TileSize)
				var dRight = colmask_get_distance_v(xRight, yRight, false, TileSize)
			
				// Get floor angle
				var Ang = dLeft <= dRight? colmask_get_angle_v(xLeft, yLeft, false) : colmask_get_angle_v(xRight, yRight, false);		
			}
			break;
			case ModeWallL:
			{	
				// Set coordinates
				var xLeft  = floor(PosX - yRadius);
				var yLeft  = floor(PosY - xRadius);
				var xRight = floor(PosX - yRadius);
				var yRight = floor(PosY + xRadius);
			
				// Get floor distances and angles
				var dLeft  = colmask_get_distance_h(xLeft, yLeft, false, TileSize)
				var dRight = colmask_get_distance_h(xRight, yRight, false, TileSize)
			
				// Get floor angle
				var Ang = dLeft <= dRight? colmask_get_angle_h(xLeft, yLeft, false) : colmask_get_angle_h(xRight, yRight, false);
			}
			break;
		}
	}
	
	// Left wall collision
	if Grounded
	{
		if (Ang < 90 or Ang > 270 or Game.ExtensiveWallCollision and Ang mod 90 = 0) and Inertia < 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide if distance is negative (frame ahead)
			switch round(Ang/90) % 4
			{
				case ModeFloor:
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
				case ModeWallR:
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
				case ModeRoof:
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
				case ModeWallL:
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
		if (Ang < 90 or Ang > 270 or Game.ExtensiveWallCollision and Ang mod 90 = 0) and Inertia > 0
		{
			// Get position
			var PlayerX = floor(PosX + Xsp);
			var PlayerY = floor(PosY + Ysp);
			
			// Collide if distance is negative (frame ahead)
			switch round(Ang/90) % 4
			{
				case ModeFloor:
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
				case ModeWallR:
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
				case ModeRoof:
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
				case ModeWallL:
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