/// @function collision_get_distance(sensor)
function collision_get_distance(sensor) 
{	
	// Set coorditanes, then find edge of the collision tile & return it
	var X = sensor[xPos];
	var Y = sensor[yPos];

	// Floor sensor
	if sensor = Sensor[FloorL] or sensor = Sensor[FloorR]
	{
		/* We are adding 16 here while grounded because floor sensors unlike
		the others are actually checking for positive distances */	
		var MaxDistance = Grounded * 16;
		
		switch CollisionMode 
		{	
			case ModeFloor:
		
				while !collision_meeting(X, Y, false) and Y < sensor[yPos] + MaxDistance
				{
					Y++;
				}
				while collision_meeting(X, Y, false)
				{
					Y--;
				}
				return Y - sensor[yPos];
			
			break;
			case ModeWallR:	
		
				while !collision_meeting(X, Y, false) and X < sensor[xPos] + MaxDistance
				{
					X++;
				}
				while collision_meeting(X, Y, false)
				{
					X--;
				}
				return X - sensor[xPos];
			
			break;
			case ModeRoof:	
		
				while !collision_meeting(X, Y, false) and Y > sensor[yPos] - MaxDistance
				{
					Y--;
				}
				while collision_meeting(X, Y, false)
				{
					Y++;
				}
				return sensor[yPos] - Y;
				
			break;
			case ModeWallL:	
		
				while !collision_meeting(X, Y, false) and X > sensor[xPos] - MaxDistance
				{
					X--;
				}
				while collision_meeting(X, Y, false)
				{
					X++;
				}
				return sensor[xPos] - X;
			
			break;			
		}	
	}
	
	// Ceiling sensor
	if sensor = Sensor[RoofL] or sensor = Sensor[RoofR]
	{
		while collision_meeting(X, Y, true)
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
		
				while collision_meeting(X, Y, true)
				{
					X++;
				}
				return sensor[xPos] - X; 
			
			break;
			case ModeWallR: 
		
				while collision_meeting(X, Y, true)
				{
					Y--; 
				}
				return sensor[yPos] - Y;
			
			break;
			case ModeRoof: 
		
				while collision_meeting(X, Y, true)
				{
					X--; 
				}
				return X - sensor[xPos];
			
			break;
			case ModeWallL: 
		
				while collision_meeting(X, Y, true)
				{
					Y++;
				}
				return Y - sensor[yPos];
			
			break;
		}	
	}
	
	// Right wall sensor
	if sensor = Sensor[WallR]
	{
		switch CollisionMode 
		{
			case ModeFloor: 
		
				while collision_meeting(X, Y, true)
				{
					X--;
				}
				return X - sensor[xPos]; 
			
			break;
			case ModeWallR: 
		
				while collision_meeting(X, Y, true)
				{
					Y++; 
				}
				return Y - sensor[yPos];
			
			break;
			case ModeRoof: 
		
				while collision_meeting(X, Y, true)
				{
					X++; 
				}
				return sensor[xPos] - X;
			
			break;
			case ModeWallL: 
		
				while collision_meeting(X, Y, true)
				{
					Y--;
				}
				return sensor[yPos] - Y;
			
			break;
		}
	}
}