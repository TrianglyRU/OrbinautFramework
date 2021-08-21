/// @function tile_check_collision_v(x,y,to_positive,ignore_top,tilelayer)
function tile_check_collision_v(x,y,to_positive,ignore_top,tilelayer)
{	
	// Return blank values if outside of the room
	if x < 0 or y < 0 or x > room_width or y > room_height 
	{
		return [32, 360];
	}
	
	// Set search direction sign
	var SearchDirection = to_positive ? 1 : -1;
	
	// Get first tile
	var FirstTile       = tilemap_get(Stage.TileLayer[tilelayer], x div TileSize, y div TileSize);
	var FirstTileIndex  = tile_get_index(FirstTile);
	var FirstTileHeight = tile_get_height(x, y, FirstTile, FirstTileIndex);
	
	// Ignore first tile if it is solidtop and we're ignoring them
	if ignore_top and FirstTileIndex > TileAmount
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
		var ResultTile      = tilemap_get(Stage.TileLayer[tilelayer], x div TileSize, (y + SearchShift * SearchDirection) div TileSize);
		var ResultTileIndex = tile_get_index(ResultTile);
	}
	
	// If first tile height is 16, get a tile above
	else
	{
		var SearchShift      = -TileSize;
		var SecondTile       = tilemap_get(Stage.TileLayer[tilelayer], x div TileSize, (y + SearchShift * SearchDirection) div TileSize);
		var SecondTileIndex  = tile_get_index(SecondTile);
		var SecondTileHeight = tile_get_height(x, y, SecondTile, SecondTileIndex);
		
		// Ignore second tile if it is solidtop and we're ignoring them
		if ignore_top and SecondTileIndex > TileAmount
		{
			SecondTileHeight = 0;
		}
		
		// Test if second tile height is 0		
		if !SecondTileHeight
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
	var ResultHeight = tile_get_height(x, y, ResultTile, ResultTileIndex);
	
	// Ignore result tile if it is solidtop and we're ignoring them
	if ignore_top and ResultTileIndex > TileAmount
	{
		ResultHeight = 0;
	}
		
	// Calculate distance to edge of the result tile
	if to_positive
	{
		var TileDistance = (y + SearchShift * SearchDirection) div TileSize * TileSize + (TileSize - ResultHeight - 1) - y;
	}
	else
	{
		var TileDistance = y - ((y + SearchShift * SearchDirection) div TileSize * TileSize + ResultHeight);
	}
	
	// Get tile angle
	var TileAngle = tile_get_angle(ResultTileIndex);
	
	// Adjust angle if it is not 360 degrees
	if TileAngle != 360
	{
		// Flip angle if tile is flipped
		if tile_get_flip(ResultTile)
		{
			TileAngle = (540 - TileAngle) mod 360;
		}
		
		// Mirror angle if tile is mirrored
		if tile_get_mirror(ResultTile)
		{
			TileAngle = 360 - TileAngle;
		}
	}
	else
	{
		// Get cardinal angle based on direction
		TileAngle = to_positive ? 360 : 180;
	}
	
	// Return data
	return [TileDistance, TileAngle];
}