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
		var dLeft  = tile_get_data_v(xLeft, yLeft, Layer, true, 0);
		var dRight = tile_get_data_v(xRight, yRight, Layer, true, 0);
		
		// Use the closest distance
		var Distance = dLeft <= dRight? dLeft : dRight;

		// When distance is negative, we're touching the floor
		if Distance < 0
		{
			// Get floor angle
			var floorAngle = dLeft <= dRight ? tile_get_data_v(xLeft, yLeft, Layer, true, 1) : tile_get_data_v(xRight, yRight, Layer, true, 1);
			
			// If we're moving downwards, calculate a momentum using floor angle
			if abs(Xsp) < abs(Ysp)
			{
				// If angle is >= 45 degrees, use vertical speed
				if floorAngle >= 45 and floorAngle <= 315
				{
					if (Ysp > 16) Ysp = 16;
					Xsp = 0;
					Inertia = floorAngle < 180 ? -Ysp : Ysp;
				}
		
				// If angle is >= 22.5 degrees, use halved vertical speed
				else if floorAngle >= 22.5 and floorAngle <= 337.5
				{
					Inertia = floorAngle <= 180 ? -Ysp / 2 : Ysp / 2;
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
		
			// Land and adhere to the floor
			Grounded = true;
			Angle    = floorAngle;
			PosY	+= Distance;
		}
	}
}