function PlayerUpdateAnglePosition()
{	
	if sensor_active(Sensor[FloorL]) and sensor_active(Sensor[FloorR])
	{
		// Get distances, then define a sensor to use
		if !Game.TileCollisionMethod
		{
			Sensor[FloorL][Dist] = colmask_get_distance(Sensor[FloorL]);
			Sensor[FloorR][Dist] = colmask_get_distance(Sensor[FloorR]);
		}
		else
		{	
			Sensor[FloorL][Dist] = tile_get_distance(Sensor[FloorL]);
			Sensor[FloorR][Dist] = tile_get_distance(Sensor[FloorR]);
		}
		var Used = Sensor[FloorL][Dist] <= Sensor[FloorR][Dist] ? FloorL : FloorR;
		
		// Get floor angle
		if !Game.TileCollisionMethod
		{
			var FloorAngle = colmask_get_angle(Sensor[Used]);
		}
		else
		{
			var FloorAngle = tile_get_angle(Sensor[Used]);
		}

		// Apply our angle and update collision mode
		if Game.ConsiderAngleDifference and !Game.TileCollisionMethod
		{	
			// if S2+ angle detection method is enabled, check for the difference
			var Difference = abs(Angle - FloorAngle);
			if  Difference < 180
			{	
				Angle = Difference > 45 ? CollisionMode * 90 : colmask_get_angle(Sensor[Used]);
			}
			else
			{	
				Angle = Difference < 315 ? CollisionMode * 90 : colmask_get_angle(Sensor[Used]);
			}	
		}
		else
		{	
			Angle = FloorAngle;
		}
		CollisionMode = round(Angle/90) % 4;
	}
}