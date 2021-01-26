function PlayerHitFloor()
{	
	if sensor_active(Sensor[FloorL]) and sensor_active(Sensor[FloorR])
	{
		// Update floor sensors position
		Sensor[FloorL][xPos] = floor(PosX - xRadius);
		Sensor[FloorL][yPos] = floor(PosY + yRadius);
		Sensor[FloorR][xPos] = floor(PosX + xRadius);
		Sensor[FloorR][yPos] = floor(PosY + yRadius);
		
		// Reset angle and find a distance for each
		Sensor[FloorL][Ang]  = 0;
		Sensor[FloorR][Ang]  = 0;
		Sensor[FloorL][Dist] = collision_get_distance(Sensor[FloorL]);
		Sensor[FloorR][Dist] = collision_get_distance(Sensor[FloorR]);
	
		// Define the sensor to use
		var Used = Sensor[FloorL][Dist] <= Sensor[FloorR][Dist] ? FloorL : FloorR;

		// When the distance is negative, we are touching the floor
		if Sensor[Used][Dist] < 0
		{	
			// Update angle
			Sensor[FloorL][Ang] = collision_get_angle(Sensor[FloorL]);
			Sensor[FloorR][Ang] = collision_get_angle(Sensor[FloorR]);
			Angle               = Sensor[Used][Ang];
		
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
			PosY += Sensor[Used][Dist];
	
			// Set flags
			Grounded = true;
		}
	}
}