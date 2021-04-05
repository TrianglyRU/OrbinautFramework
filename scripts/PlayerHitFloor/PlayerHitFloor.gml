function PlayerHitFloor()
{	
	// Do not collide if we're not allowed to
	if (Ysp > 0 or abs(Xsp) > abs(Ysp)) and AllowCollision == true
	{	
		// Get tiles
		var tileDataLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
		var tileDataRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
		
		// Use tile with closest distance
		if tileDataLeft[0] <= tileDataRight[0]
		{
			var floorDistance = tileDataLeft[0];
			var floorAngle    = tileDataLeft[1];
		}
		else
		{
			var floorDistance = tileDataRight[0];
			var floorAngle    = tileDataRight[1];
		}
		
		// Perform floor collision
		if floorDistance < 0
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
			PosY	+= floorDistance;
			Grounded = true;
		}
	}
}