// Function 1
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

// Function 2
function colmask_get_angle_v(xTile, yTile, toPositive)
{
	// Find angle downwards
	if toPositive
	{
		var AX = xTile -       xTile mod TileSize;
		var BX = xTile + (15 - xTile mod TileSize);
		var AY = yTile;	
		var BY = yTile;
				
		while !colmask_meeting(AX, AY, false) and AY < yTile + TileSize * 2
		{
			++AY;
		}
		while !colmask_meeting(BX, BY, false) and BY < yTile + TileSize * 2 
		{
			++BY;
		}
		while colmask_meeting(AX, AY, false) and AY > yTile - TileSize 
		{
			--AY;
		}
		while colmask_meeting(BX, BY, false) and BY > yTile - TileSize 
		{
			--BY;
		}
	}
	
	// Find angle upwards
	else
	{
		var AX = xTile + (15 - xTile mod TileSize);
		var BX = xTile       - xTile mod TileSize;
		var AY = yTile;	
		var BY = yTile;	
					
		while !colmask_meeting(AX, AY, false) and AY > yTile - TileSize * 2
		{
			--AY;
		}
		while !colmask_meeting(BX, BY, false) and BY > yTile - TileSize * 2
		{
			--BY;
		}
		while colmask_meeting(AX, AY, false) and AY < yTile + TileSize
		{
			++AY;
		}
		while colmask_meeting(BX, BY, false) and BY < yTile + TileSize
		{
			++BY;
		}
	}
	
	// Return measurement
	return point_direction(AX, AY, BX, BY);
}	