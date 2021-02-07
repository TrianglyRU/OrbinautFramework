function PlayerHitFloor()
{	
	// Floor angle is always 0 in air until we touch the floor
	FloorAngle = 0;
	
	if Ysp > 0 or abs(Xsp) > abs(Ysp)
	{	
		// Set coordinates
		var xLeft  = floor(PosX - xRadius);
		var yLeft  = floor(PosY + yRadius);
		var xRight = floor(PosX + xRadius);
		var yRight = floor(PosY + yRadius);
			
		// Get floor distances
		var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);
		var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
		
		// Use the closest distance
		var Distance = dLeft <= dRight? dLeft : dRight;

		// When distance is negative, we're touching the floor
		if Distance < 0
		{
			// Get floor angle
			FloorAngle = dLeft <= dRight ? tile_get_angle(xLeft, yLeft, Layer) : tile_get_angle(xRight, yRight, Layer);
			
			// If we're moving downwards, calculate a momentum using floor angle
			if abs(Xsp) < abs(Ysp)
			{
				// If angle is >= 45 degrees, use vertical speed
				if FloorAngle >= 45 and FloorAngle <= 315
				{
					Xsp = 0;
					if (Ysp > 16) Ysp = 16;
					Inertia = FloorAngle < 180 ? -Ysp : Ysp;
				}
		
				// If angle is >= 22.5 degrees, use halved vertical speed
				else if FloorAngle >= 22.5 and FloorAngle <= 337.5
				{
					Inertia = FloorAngle <= 180 ? -Ysp / 2 : Ysp / 2;
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
			Grounded  = true;	
			Angle     = FloorAngle;
			PosY     += Distance;
		}
	}
}