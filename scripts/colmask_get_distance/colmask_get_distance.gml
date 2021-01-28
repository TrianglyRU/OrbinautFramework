/// @function colmask_get_distance(sensor)
function colmask_get_distance(sensor) 
{	
	// Floor sensor
	if sensor = Sensor[FloorL] or sensor = Sensor[FloorR]
	{
		/* We are adding 16 here while grounded because floor sensors unlike
		the others are actually checking for positive distances */	
		var MaxDistance = Grounded * 16;
		
		switch CollisionMode 
		{	
			case ModeFloor:
				
				// Update position
				Sensor[FloorL][xPos] = floor(PosX - xRadius);
				Sensor[FloorL][yPos] = floor(PosY + yRadius);
				Sensor[FloorR][xPos] = floor(PosX + xRadius);
				Sensor[FloorR][yPos] = floor(PosY + yRadius);
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while !colmask_meeting(X, Y, false) and Y < sensor[yPos] + MaxDistance
				{
					Y++;
				}
				while colmask_meeting(X, Y, false)
				{
					Y--;
				}
				return Y - sensor[yPos];
			
			break;
			case ModeWallR:	
				
				// Update position
				Sensor[FloorL][xPos] = floor(PosX + yRadius);
				Sensor[FloorL][yPos] = floor(PosY + xRadius);
				Sensor[FloorR][xPos] = floor(PosX + yRadius);
				Sensor[FloorR][yPos] = floor(PosY - xRadius);
				var X = sensor[xPos];
				var Y = sensor[yPos];
		
				// Find distance
				while !colmask_meeting(X, Y, false) and X < sensor[xPos] + MaxDistance
				{
					X++;
				}
				while colmask_meeting(X, Y, false)
				{
					X--;
				}
				return X - sensor[xPos];
			
			break;
			case ModeRoof:	
				
				// Update position
				Sensor[FloorL][xPos] = floor(PosX + xRadius);
				Sensor[FloorL][yPos] = floor(PosY - yRadius);
				Sensor[FloorR][xPos] = floor(PosX - xRadius);
				Sensor[FloorR][yPos] = floor(PosY - yRadius);
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while !colmask_meeting(X, Y, false) and Y > sensor[yPos] - MaxDistance
				{
					Y--;
				}
				while colmask_meeting(X, Y, false)
				{
					Y++;
				}
				return sensor[yPos] - Y;
				
			break;
			case ModeWallL:	
					
				// Update position
				Sensor[FloorL][xPos] = floor(PosX - yRadius);
				Sensor[FloorL][yPos] = floor(PosY - xRadius);
				Sensor[FloorR][xPos] = floor(PosX - yRadius);
				Sensor[FloorR][yPos] = floor(PosY + xRadius);
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while !colmask_meeting(X, Y, false) and X > sensor[xPos] - MaxDistance
				{
					X--;
				}
				while colmask_meeting(X, Y, false)
				{
					X++;
				}
				return sensor[xPos] - X;
			
			break;			
		}	
	}
	
	// Roof sensor
	if sensor = Sensor[RoofL] or sensor = Sensor[RoofR]
	{	
		// Update position
		Sensor[RoofL][xPos] = floor(PosX - xRadius);
		Sensor[RoofL][yPos] = floor(PosY - yRadius);
		Sensor[RoofR][xPos] = floor(PosX + xRadius);
		Sensor[RoofR][yPos] = floor(PosY - yRadius);
		var X = sensor[xPos];
		var Y = sensor[yPos];
	
		// Find distances
		while colmask_meeting(X, Y, true)
		{
			Y++;
		}
		return sensor[yPos] - Y;
	}
	
	// Left wall sensor
	if sensor = Sensor[WallL]
	{	
		switch CollisionMode 
		{
			case ModeFloor: 
			
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					X++;
				}
				return sensor[xPos] - X; 
			
			break;
			case ModeWallR: 
				
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					Y--; 
				}
				return Y - sensor[yPos];
			
			break;
			case ModeRoof: 
				
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					X--; 
				}
				return X - sensor[xPos];
			
			break;
			case ModeWallL: 
				
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					Y++;
				}
				return sensor[yPos] - Y;
			
			break;
		}	
	}
	
	// Right wall sensor
	if sensor = Sensor[WallR]
	{	
		switch CollisionMode 
		{
			case ModeFloor: 
				
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					X--;
				}
				return X - sensor[xPos]; 
			
			break;
			case ModeWallR: 
				
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					Y++; 
				}
				return sensor[yPos] - Y;
			
			break;
			case ModeRoof: 
				
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
				
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					X++; 
				}
				return sensor[xPos] - X;
			
			break;
			case ModeWallL: 
					
				// Update position
				var X = sensor[xPos];
				var Y = sensor[yPos];
		
				// Find distance
				while colmask_meeting(X, Y, true)
				{
					Y--;
				}
				return Y - sensor[yPos];
			
			break;
		}
	}
}