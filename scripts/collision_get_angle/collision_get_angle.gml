/// @function collision_get_angle(sensor)
function collision_get_angle(sensor) 
{	
	// Get floor sensor coordinates
	var X = sensor[xPos];
	var Y = sensor[yPos];
	
	// Floor sensor
	if sensor = Sensor[FloorL] or sensor = Sensor[FloorR]
	{
		// Set coordinates to measure an angle from and adjust them
		switch CollisionMode 
		{
			case ModeFloor:
		
				var AX = X -       X mod 16;
				var BX = X + (15 - X mod 16);
				var AY = Y;	
				var BY = Y;
				
				while !collision_meeting(AX, AY, false) and AY < sensor[yPos] + 32
				{
					++AY;
				}
				while !collision_meeting(BX, BY, false) and BY < sensor[yPos] + 32 
				{
					++BY;
				}
				while collision_meeting(AX, AY, false) and AY > sensor[yPos] - 16 
				{
					--AY;
				}
				while collision_meeting(BX, BY, false) and BY > sensor[yPos] - 16 
				{
					--BY;
				}
			
			break;
			case ModeWallR:
		
				var AX = X;
				var BX = X;
				var AY = Y + (15 - Y mod 16);	
				var BY = Y       - Y mod 16;
				
				while !collision_meeting(AX, AY, true) and AX < sensor[xPos] + 32 
				{
					++AX;
				}
				while !collision_meeting(BX, BY, true) and BX < sensor[xPos] + 32 
				{
					++BX;
				}	
				while collision_meeting(AX, AY, true) and AX > sensor[xPos] - 16 
				{
					--AX;
				}	
				while collision_meeting(BX, BY, true) and BX > sensor[xPos] - 16 
				{
					--BX;
				}
			
			break;
			case ModeRoof:
		
				var AX = X + (15 - X mod 16);
				var BX = X       - X mod 16;
				var AY = Y;	
				var BY = Y;	
					
				while !collision_meeting(AX, AY, false) and AY > sensor[yPos] - 32
				{
					--AY;
				}
				while !collision_meeting(BX, BY, false) and BY > sensor[yPos] - 32 
				{
					--BY;
				}
				while collision_meeting(AX, AY, false) and AY < sensor[yPos] + 16
				{
					++AY;
				}
				while collision_meeting(BX, BY, false) and BY < sensor[yPos] + 16
				{
					++BY;
				}	
			
			break;
			case ModeWallL:
		
				var AX = X;
				var BX = X;
				var AY = Y       - Y mod 16;
				var BY = Y + (15 - Y mod 16);
					
				while !collision_meeting(AX, AY, true) and AX > sensor[xPos] - 32 
				{
					--AX;
				}
				while !collision_meeting(BX, BY, true) and BX > sensor[xPos] - 32 
				{
					--BX;
				}
				while collision_meeting(AX, AY, true) and AX < sensor[xPos] + 16  
				{
					++AX;
				}
				while collision_meeting(BX, BY, true) and BX < sensor[xPos] + 16  
				{
					++BX;
				}
			
			break;
		}
	
		// Return measurement
		return point_direction(AX, AY, BX, BY);
	}
	
	// Ceiling sensor
	if sensor = Sensor[RoofL] or sensor = Sensor[RoofR]
	{
		// Set coordinates to measure an angle from and adjust them
		var AX = X -       X mod 16;
		var BX = X + (15 - X mod 16);
		var AY = Y;	
		var BY = Y;	
	
		while !collision_meeting(AX, AY, true) and AY > sensor[yPos] - 32 
		{
			--AY;
		}
		while !collision_meeting(BX, BY, true) and BY > sensor[yPos] - 32 
		{
			--BY;
		}
		while collision_meeting(AX, AY, true) 
		{
			++AY;
		}
		while collision_meeting(BX, BY, true) 
		{
			++BY;
		}
	
		// Return measurement
		return point_direction(BX, BY, AX, AY);
	}
}