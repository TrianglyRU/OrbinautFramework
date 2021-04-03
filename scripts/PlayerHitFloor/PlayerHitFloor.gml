function PlayerHitFloor()
{	
	// Do not collide if we're not allowed to
	if (Ysp > 0 or abs(Xsp) > abs(Ysp)) and AllowCollision == true
	{	
		// Set coordinates
		var xLeft  = floor(PosX - xRadius);
		var yLeft  = floor(PosY + yRadius);
		var xRight = floor(PosX + xRadius);
		var yRight = floor(PosY + yRadius);
			
		// Get floor distances
		var dLeft  = tile_get_distance_v(xLeft, yLeft, true, false, Layer);
		var dRight = tile_get_distance_v(xRight, yRight, true, false, Layer);
		
		// Get floor angles
		var aLeft  = tile_get_angle_v(xLeft, yLeft, true, false, Layer);
		var aRight = tile_get_angle_v(xRight, yRight, true, false, Layer);
		
		// Collide using closest distance
		var floorDistance = dLeft <= dRight ? dLeft : dRight;
		var floorAngle    = dLeft <= dRight ? aLeft : aRight;
		
		if  floorDistance < 0
		{
			// Apply angle
			Angle = floorAngle;
			
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
			PosY	+= floorDistance;
		}
	}
}