function PlayerCollideFloorMasks()
{	
	if sensor_active(Sensor[FloorL]) and sensor_active(Sensor[FloorR])
	{
		// Update floor sensors position
		switch CollisionMode 
		{
			case ModeFloor:
				Sensor[FloorL][xPos] = floor(PosX - xRadius);
				Sensor[FloorL][yPos] = floor(PosY + yRadius);
				Sensor[FloorR][xPos] = floor(PosX + xRadius);
				Sensor[FloorR][yPos] = floor(PosY + yRadius);	
			break;
			case ModeWallR:
				Sensor[FloorL][xPos] = floor(PosX + yRadius);
				Sensor[FloorL][yPos] = floor(PosY + xRadius);
				Sensor[FloorR][xPos] = floor(PosX + yRadius);
				Sensor[FloorR][yPos] = floor(PosY - xRadius);
			break;
			case ModeRoof:
				Sensor[FloorL][xPos] = floor(PosX + xRadius);
				Sensor[FloorL][yPos] = floor(PosY - yRadius);
				Sensor[FloorR][xPos] = floor(PosX - xRadius);
				Sensor[FloorR][yPos] = floor(PosY - yRadius);
			break;
			case ModeWallL:
				Sensor[FloorL][xPos] = floor(PosX - yRadius);
				Sensor[FloorL][yPos] = floor(PosY - xRadius);
				Sensor[FloorR][xPos] = floor(PosX - yRadius);
				Sensor[FloorR][yPos] = floor(PosY + xRadius);
			break;
		}
	
		// Calculate distances and angles for each floor sensor
		Sensor[FloorL][Dist] = collision_get_distance(Sensor[FloorL]);
		Sensor[FloorR][Dist] = collision_get_distance(Sensor[FloorR]);
		Sensor[FloorL][Ang]  = collision_get_angle(Sensor[FloorL]);
		Sensor[FloorR][Ang]  = collision_get_angle(Sensor[FloorR]);

		// Define the sensor to use
		var Used = Sensor[FloorL][Dist] <= Sensor[FloorR][Dist] ? FloorL : FloorR;
	
		// Calculate a winning tile angle and update collision mode
		if Game.CardinalSlopeAngle
		{	
			// if S2+ angle detection method is enabled, check for the difference
			var angle_diff = abs(Angle - Sensor[Used][Ang]);
			if  angle_diff < 180
			{	
				Angle = angle_diff > 45 ? CollisionMode * 90 : Sensor[Used][Ang];
			}
			else
			{	
				Angle = angle_diff < 315 ? CollisionMode * 90 : Sensor[Used][Ang];
			}	
		}
		else
		{	
			Angle = Sensor[Used][Ang];
		}
		CollisionMode = round(Angle/90) % 4;
			
		// Go airborne if the distance is greater than collision tolerance and we're not standing on object
		if !Game.SpeedFloorClip 
		{
			CollisionDistance = 14;
		} 
		else 
		{
			CollisionDistance = min(4 + abs(floor(CollisionMode mod 2 = 0 ? Xsp : Ysp)), 14);
		}
		if Sensor[Used][Dist] > CollisionDistance
		{
			Grounded = false; 
		}
	
		// else adhere to the floor if we're not 14 pixels into it
		else //if Sensor[WINNING][DISTANCE] >= -14 
		{
			switch CollisionMode 
			{	
				case ModeFloor:	PosY += Sensor[Used][Dist]; break;
				case ModeWallR: PosX += Sensor[Used][Dist]; break;
				case ModeRoof:  PosY -= Sensor[Used][Dist]; break;
				case ModeWallL: PosX -= Sensor[Used][Dist]; break;
			}
		}
	}
	else
	{
		Angle = 0;
	}
}