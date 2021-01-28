function colmask_get_angle_h(xTile, yTile, toPositive)
{	
	// Find angle to the right
	if toPositive
	{
		var AX = xTile;
		var BX = xTile;
		var AY = yTile + (15 - yTile mod TileSize);	
		var BY = yTile       - yTile mod TileSize;
				
		while !colmask_meeting(AX, AY, true) and AX < xTile + TileSize * 2 
		{
			++AX;
		}
		while !colmask_meeting(BX, BY, true) and BX < xTile + TileSize * 2 
		{
			++BX;
		}	
		while colmask_meeting(AX, AY, true) and AX > xTile - TileSize 
		{
			--AX;
		}	
		while colmask_meeting(BX, BY, true) and BX > xTile - TileSize 
		{
			--BX;
		}
	}
	
	// Find angle to the left
	else
	{
		var AX = xTile;
		var BX = xTile;
		var AY = yTile       - yTile mod TileSize;
		var BY = yTile + (15 - yTile mod TileSize);
					
		while !colmask_meeting(AX, AY, true) and AX > xTile - TileSize * 2 
		{
			--AX;
		}
		while !colmask_meeting(BX, BY, true) and BX > xTile - TileSize * 2 
		{
			--BX;
		}
		while colmask_meeting(AX, AY, true) and AX < xTile + TileSize  
		{
			++AX;
		}
		while colmask_meeting(BX, BY, true) and BX < xTile + TileSize  
		{
			++BX;
		}
	}
	
	// Return measurement
	return point_direction(AX, AY, BX, BY);
}