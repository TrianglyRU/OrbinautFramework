/// @function colmask_get_angle_v(xTile, yTile, toPositive)
function colmask_get_angle_v(xTile, yTile, toPositive)
{
	// Check if player has changed the tile 
	var PrevTileLeft  = floor(PosXPrev - xRadius) div TileSize;
	var PrevTileRight = floor(PosXPrev + xRadius) div TileSize;
	var TileLeft	  = floor(PosX	   - xRadius) div TileSize;
	var TileRight	  = floor(PosX	   + xRadius) div TileSize;
	
	if Grounded and (PrevTileLeft != TileLeft or PrevTileRight != TileRight) or !Grounded
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
			while colmask_meeting(AX, AY, false) and AY > yTile - TileSize * 2
			{
				--AY;
			}
			while colmask_meeting(BX, BY, false) and BY > yTile - TileSize * 2
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
			while colmask_meeting(AX, AY, false) and AY < yTile + TileSize * 2
			{
				++AY;
			}
			while colmask_meeting(BX, BY, false) and BY < yTile + TileSize * 2
			{
				++BY;
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