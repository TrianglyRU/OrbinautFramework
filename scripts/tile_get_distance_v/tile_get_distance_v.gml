/// @function tile_get_distance_v(X, Y, toPositive, noSolidTop, Layer)
function tile_get_distance_v(X, Y, toPositive, noSolidTop, Layer)
{
	// Report script error
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Get tile and read its height
	var Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index  = tile_get_index(Tile) mod TileAmount;
	var Height = Game.HeightValueOf[Index][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];
	
	// Use current tile
	var Tile2 = 0;
	
	// Use a tile below if this tile height is 0
	if !Height
	{
		Tile2 = +TileSize;
	}
	
	// Use a tile above if this tile height is 16 and we're checking for the distance
	else if Height = TileSize
	{
		if !noSolidTop
		{
			Tile2 = -TileSize;
		}
	}
	
	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, (Y + Tile2) div TileSize);
		Index  = tile_get_index(Tile) mod TileAmount;
		Height = Game.HeightValueOf[Index][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];

	}
		
	// Return distance to the edge of our tile
	if noSolidTop and tile_get_index(Tile) > TileAmount
	{
		return TileSize;
	}
	else
	{
		return (Tile2 - (Y mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
	}
}