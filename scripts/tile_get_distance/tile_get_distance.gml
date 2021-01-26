/// @function colmask_get_distance(sensor)
function tile_get_distance(sensor) 
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
		
				while !tile_meeting(X, Y, "CollisionTilesA") and Y < sensor[yPos] + MaxDistance
				{
					Y++;
				}
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					Y--;
				}
				return Y - sensor[yPos];
			
			break;
			case ModeWallR:	
		
				while !tile_meeting(X, Y, "CollisionTilesA") and X < sensor[xPos] + MaxDistance
				{
					X++;
				}
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					X--;
				}
				return X - sensor[xPos];
			
			break;
			case ModeRoof:	
		
				while !tile_meeting(X, Y, "CollisionTilesA") and Y > sensor[yPos] - MaxDistance
				{
					Y--;
				}
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					Y++;
				}
				return sensor[yPos] - Y;
				
			break;
			case ModeWallL:	
		
				while !tile_meeting(X, Y, "CollisionTilesA") and X > sensor[xPos] - MaxDistance
				{
					X--;
				}
				while tile_meeting(X, Y, "CollisionTilesA")
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
		while tile_meeting(X, Y, "CollisionTilesA")
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
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					X++;
				}
				return sensor[xPos] - X; 
			
			break;
			case ModeWallR: 
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					Y--; 
				}
				return sensor[yPos] - Y;
			
			break;
			case ModeRoof: 
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					X--; 
				}
				return X - sensor[xPos];
			
			break;
			case ModeWallL: 
		
				while tile_meeting(X, Y, "CollisionTilesA")
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
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					X--;
				}
				return X - sensor[xPos]; 
			
			break;
			case ModeWallR: 
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					Y++; 
				}
				return Y - sensor[yPos];
			
			break;
			case ModeRoof: 
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					X++; 
				}
				return sensor[xPos] - X;
			
			break;
			case ModeWallL: 
		
				while tile_meeting(X, Y, "CollisionTilesA")
				{
					Y--;
				}
				return sensor[yPos] - Y;
			
			break;
		}
	}
}