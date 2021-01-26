function PlayerHitCeiling()
{	
	if sensor_active(Sensor[RoofL]) and sensor_active(Sensor[RoofR])
	{
		// Update ceiling sensors position
		Sensor[RoofL][xPos] = floor(PosX - xRadius);
		Sensor[RoofL][yPos] = floor(PosY - yRadius);
		Sensor[RoofR][xPos] = floor(PosX + xRadius);
		Sensor[RoofR][yPos] = floor(PosY - yRadius);

		// Reset angle and find a distance for each
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
		Sensor[RoofL][Ang] = 0;
		Sensor[RoofR][Ang] = 0;
	
		// Define the sensor to use
		var Used = Sensor[RoofL][Dist] <= Sensor[RoofR][Dist] ? RoofL : RoofR;
	
		// When the distance is negative, we are touching the ceiling
		if Sensor[Used][Dist] < 0
		{	
			// Collide 
			PosY -= Sensor[Used][Dist];
			
			// If moving upwards, calculate tile angles and reattach if it is steep enough
			if abs(Ysp) > abs(Xsp)
			{
				if !Game.TileCollisionMethod
				{
					Sensor[RoofL][Ang] = colmask_get_angle(Sensor[RoofL]);
					Sensor[RoofR][Ang] = colmask_get_angle(Sensor[RoofR]);
				}
				else
				{
					Sensor[RoofL][Ang] = tile_get_angle(Sensor[RoofL]);
					Sensor[RoofR][Ang] = tile_get_angle(Sensor[RoofR]);
				}
				
				// Сheck the winning angle
				if Sensor[Used][Ang] < 135 or Sensor[Used][Ang] > 225
				{	
					if !Game.TileCollisionMethod
					{
						Inertia	      = Sensor[Used][Ang] < 180 ? -Ysp : Ysp;
						Angle		  = Sensor[Used][Ang];					
						Grounded      = true;
						CollisionMode = round(Angle/90) % 4;
					}
					else
					{
						Ysp = 0;
					}
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