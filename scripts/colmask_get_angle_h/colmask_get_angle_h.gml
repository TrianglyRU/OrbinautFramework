/// @function colmask_get_angle_h(xTile, yTile, toPositive)
function colmask_get_angle_h(xTile, yTile, toPositive)
{	
	// Check if player has changed the tile 
	var PrevTileLeft  = floor(PosYPrev + xRadius) div TileSize;
	var PrevTileRight = floor(PosYPrev - xRadius) div TileSize;
	var TileLeft	  = floor(PosY	   + xRadius) div TileSize;
	var TileRight	  = floor(PosY	   - xRadius) div TileSize;
	
	if Grounded and (PrevTileLeft != TileLeft or PrevTileRight != TileRight) or !Grounded
	{
		// Find angle to the right
		if toPositive
		{
			var AX = xTile;
			var BX = xTile;
			var AY = yTile + (15 - yTile mod TileSize);	
			var BY = yTile       - yTile mod TileSize;
			
			// When moving up
			while !colmask_meeting(AX, AY, false) and AX < xTile + TileSize * 2 
			{
				++AX;
			}
			while !colmask_meeting(BX, BY, false) and BX < xTile + TileSize * 2 
			{
				++BX;
			}	
			while colmask_meeting(AX, AY, true) and AX > xTile - TileSize * 2
			{
				--AX;
			}	
			while colmask_meeting(BX, BY, true) and BX > xTile - TileSize * 2
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
			while colmask_meeting(AX, AY, true) and AX < xTile + TileSize * 2
			{
				++AX;
			}
			while colmask_meeting(BX, BY, true) and BX < xTile + TileSize * 2 
			{
				++BX;
			}
		}
	
		// Return measurement
		return point_direction(AX, AY, BX, BY);
	}
	else
	{
		return Angle;
	}
}