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