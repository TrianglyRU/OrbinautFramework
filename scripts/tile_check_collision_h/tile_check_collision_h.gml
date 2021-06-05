/// @function tile_check_collision_h(startX, startY, toPositive, ignoreSolidTop, tileLayer)
function tile_check_collision_h(startX, startY, toPositive, ignoreSolidTop, tileLayer)
{	
	// Return blank values if outside of the room
	if startX < 0 or startY < 0 or startX > room_width or startY > room_height 
	{
		return [32, 360];
	}
	
	// Set search direction sign
	var SearchDirection = toPositive ? 1 : -1;
	
	// Get first tile
	var FirstTile      = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, startY div TileSize);
	var FirstTileIndex = tile_get_index(FirstTile);
	var FirstTileWidth = tile_get_width(startX, startY, FirstTile, FirstTileIndex);
	
	// Ignore first tile if it is solidtop and we're ignoring them
	if ignoreSolidTop and FirstTileIndex >= TileAmount
	{
		FirstTileWidth = 0;
	}
	
	// If first tile width is in range of [1, 15], use this tile
	if FirstTileWidth != 0 and FirstTileWidth != TileSize
	{
		var SearchShift     = 0;
		var ResultTile      = FirstTile;
		var ResultTileIndex = FirstTileIndex;
	}
	
	// If first tile width is 0, use a tile below
	else if FirstTileWidth == 0
	{
		var SearchShift     = TileSize;
		var ResultTile      = tilemap_get(Stage.TileLayer[tileLayer], (startX + SearchShift * SearchDirection) div TileSize, startY div TileSize);
		var ResultTileIndex = tile_get_index(ResultTile);
	}
	
	// If first tile width is 16, get a tile above
	else
	{
		var SearchShift     = -TileSize;
		var SecondTile      = tilemap_get(Stage.TileLayer[tileLayer], (startX + SearchShift * SearchDirection) div TileSize, startY div TileSize);
		var SecondTileIndex = tile_get_index(SecondTile);
		var SecondTileWidth = tile_get_width(startX, startY, SecondTile, SecondTileIndex);
		
		// Ignore second tile if it is solidtop and we're ignoring them
		if ignoreSolidTop and SecondTileIndex >= TileAmount
		{
			SecondTileWidth = 0;
		}
		
		// Test if second tile height is 0
		if SecondTileWidth == 0
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
	
	// Get result tile width
	var ResultWidth = tile_get_width(startX, startY, ResultTile, ResultTileIndex);
	
	// Ignore result tile if it is solidtop and we're ignoring them
	if ignoreSolidTop and ResultTileIndex >= TileAmount
	{
		ResultWidth = 0;
	}
	
	// Calculate distance to edge of the result tile
	if toPositive
	{
		var TileDistance = (startX + SearchShift * SearchDirection) div TileSize * TileSize + (TileSize - ResultWidth - 1) - startX;
	}
	else
	{
		var TileDistance = startX - ((startX + SearchShift * SearchDirection) div TileSize * TileSize + ResultWidth);
	}
	
	// Force cardinal angles for mirrored tiles based on check direction
	if toPositive and tile_get_mirror(ResultTile)
	{
		var TileAngle = 90;
	}
	else if !toPositive and !tile_get_mirror(ResultTile)
	{
		var TileAngle = 270;
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
	
	// Return data
	return [TileDistance, TileAngle];
}