/// @function tile_check_collision_v(startX, startY, toPositive, ignoreSolidTop, tileLayer)
function tile_check_collision_v(startX, startY, toPositive, ignoreSolidTop, tileLayer)
{	
	// Return blank values if outside of the room
	if startX < 0 or startY < 0 or startX > room_width or startY > room_height 
	{
		return [32, 360];
	}
	
	// Set search direction sign
	var SearchDirection = toPositive ? 1 : -1;
	
	// Get first tile
	var FirstTile       = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, startY div TileSize);
	var FirstTileIndex  = tile_get_index(FirstTile);
	var FirstTileHeight = tile_get_height(startX, startY, FirstTile, FirstTileIndex);
	
	// Ignore first tile if it is solidtop and we're ignoring them
	if ignoreSolidTop and FirstTileIndex >= TileAmount
	{
		FirstTileHeight = 0;
	}
	
	// If first tile height is in range of [1, 15], use this tile
	if FirstTileHeight != 0 and FirstTileHeight != TileSize
	{
		var SearchShift     = 0;
		var ResultTile      = FirstTile;
		var ResultTileIndex = FirstTileIndex;
	}
	
	// If first tile height is 0, use a tile below
	else if FirstTileHeight == 0
	{
		var SearchShift     = TileSize;
		var ResultTile      = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, (startY + SearchShift * SearchDirection) div TileSize);
		var ResultTileIndex = tile_get_index(ResultTile);
	}
	
	// If first tile height is 16, get a tile above
	else
	{
		var SearchShift      = -TileSize;
		var SecondTile       = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, (startY + SearchShift * SearchDirection) div TileSize);
		var SecondTileIndex  = tile_get_index(SecondTile);
		var SecondTileHeight = tile_get_height(startX, startY, SecondTile, SecondTileIndex);
		
		// Ignore second tile if it is solidtop and we're ignoring them
		if ignoreSolidTop and SecondTileIndex >= TileAmount
		{
			SecondTileHeight = 0;
		}
		
		// Test if second tile height is 0		
		if SecondTileHeight == 0
		{
			// If it is, use first tile
			var SearchShift     = 0
			var ResultTile      = FirstTile;
			var ResultTileIndex = FirstTileIndex;
		}
		else
		{
			// If it is not, use second tile
			var ResultTile      = SecondTile;
			var ResultTileIndex = SecondTileIndex;
		}
	}
		
	// Get result tile height
	var ResultHeight = tile_get_height(startX, startY, ResultTile, ResultTileIndex);
	
	// Ignore result tile if it is solidtop and we're ignoring them
	if ignoreSolidTop and ResultTileIndex >= TileAmount
	{
		ResultHeight = 0;
	}
		
	// Calculate distance to edge of the result tile
	if toPositive
	{
		var TileDistance = (startY + SearchShift * SearchDirection) div TileSize * TileSize + (TileSize - ResultHeight - 1) - startY;
	}
	else
	{
		var TileDistance = startY - ((startY + SearchShift * SearchDirection) div TileSize * TileSize + ResultHeight);
	}
	
	// Return cardinal angle for full solid block
	if ResultTileIndex == 0 or ResultTileIndex == 1 or ResultTileIndex == TileAmount
	{
		var TileAngle = toPositive ? 360 : 180;
	}
	else
	{
		// Force cardinal angles for flipped tiles based on check direction
		if toPositive and tile_get_flip(ResultTile)
		{
			var TileAngle = 360;
		}
		else if !toPositive and !tile_get_flip(ResultTile)
		{
			var TileAngle = 180;
		}
		
		// Get angle normally
		else
		{
			// Get regular angle value
			var TileAngle = tile_get_angle(ResultTileIndex);
			
			// Check if tile is flipped
			if tile_get_flip(ResultTile)
			{
				TileAngle = (540 - TileAngle) mod 360;
			}
			
			// Check if tile is mirrored and finally return its angle
			TileAngle = tile_get_mirror(ResultTile) ? 360 - TileAngle : TileAngle;
		}
	}
	
	// Return data
	return [TileDistance, TileAngle];
}