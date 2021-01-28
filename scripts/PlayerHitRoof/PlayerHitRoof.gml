function PlayerHitRoof()
{	
	if sensor_active(Sensor[RoofL]) and sensor_active(Sensor[RoofR])
	{
		// Get distances, then define a sensor to use
		if !Game.TileCollisionMethod
		{
			Sensor[RoofL][Dist] = colmask_get_distance(Sensor[RoofL]);
			Sensor[RoofR][Dist] = colmask_get_distance(Sensor[RoofR]);
		}
		else
		{
			Sensor[RoofL][Dist] = tile_get_distance(Sensor[RoofL]);
			Sensor[RoofR][Dist] = tile_get_distance(Sensor[RoofR]);
		}
		var Used = Sensor[RoofL][Dist] <= Sensor[RoofR][Dist] ? RoofL : RoofR;
	
		// When the distance is negative, we are touching the ceiling
		if Sensor[Used][Dist] < 0
		{	
			// Collide 
			PosY -= Sensor[Used][Dist];
			
			// If moving upwards, calculate tile angles and reattach if it is steep enough
			if abs(Ysp) > abs(Xsp)
			{	
				// Get roof angle
				if !Game.TileCollisionMethod
				{
					var RoofAngle = colmask_get_angle(Sensor[Used]);
				}
				else
				{
					var RoofAngle = tile_get_angle(Sensor[Used]);
				}
				
				// Check if roof is steep enough
				if RoofAngle < 135 or RoofAngle > 225
				{	
					Inertia	      = RoofAngle < 180 ? -Ysp : Ysp;
					Angle		  = RoofAngle;					
					CollisionMode = round(Angle/90) % 4;
					Grounded      = true;
				} 
				else 
				{
					Ysp = 0;
				}
			}
			
			// else just reset our vertical speed
			else
			{	
				if (Ysp < 0) Ysp = 0;
			}
		}	
	}
}