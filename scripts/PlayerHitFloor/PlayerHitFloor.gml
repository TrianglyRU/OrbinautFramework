function PlayerHitFloor()
{	
	if Ysp > 0 or abs(Xsp) > abs(Ysp)
	{	
		// Set coordinates
		var xLeft  = floor(PosX - xRadius);
		var yLeft  = floor(PosY + yRadius);
		var xRight = floor(PosX + xRadius);
		var yRight = floor(PosY + yRadius);
			
		// Get floor distances
		var dLeft  = colmask_get_distance_v(xLeft, yLeft, true, TileSize)
		var dRight = colmask_get_distance_v(xRight, yRight, true, TileSize)
		
		// Use the shortest distance
		var Distance = dLeft <= dRight? dLeft : dRight;

		// When distance is negative, we're touching the floor
		if Distance < 0
		{
			// Get floor angle
			Angle = dLeft <= dRight? colmask_get_angle_v(xLeft, yLeft, true) : colmask_get_angle_v(xRight, yRight, true);
			
			// If we're moving downwards, calculate a momentum using floor angle
			if abs(Xsp) < abs(Ysp)
			{
				// If angle is >= 45 degrees, use vertical speed
				if Angle >= 45 and Angle <= 315
				{
					Xsp = 0;
					if (Ysp > 16) Ysp = 16;
					Inertia = Angle < 180 ? -Ysp : Ysp;
				}
		
				// If angle is >= 22.5 degrees, use vertical speed (halved)
				else if Angle >= 22.5 and Angle <= 337.5
				{
					Inertia = Angle <= 180 ? -Ysp / 2 : Ysp / 2;
				}
		
				// If angle is < 22.5 degrees, use horizontal speed
				else 
				{	
					Ysp     = 0;
					Inertia = Xsp;	
				}
			}
		
			// If we're moving to the left or right, use xsp
			else 
			{	
				Ysp     = 0;
				Inertia = Xsp;
			}
		
			// Adhere to the floor
			PosY += Distance;
	
			// Land and set animation
			Grounded  = true;
		}
	}
}