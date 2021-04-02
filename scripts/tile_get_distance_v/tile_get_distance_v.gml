/// @function tile_get_distance_v(X, Y, toPositive, noSolidTop, Layer)
function tile_get_distance_v(X, Y, toPositive, noSolidTop, Layer)
{
	// Do not perform outside of the room
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Get tile and read its height
	var Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index  = tile_get_index(Tile) mod TileAmount;
	var Height = Game.HeightValueOf[Index][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];
	
	// Do not use second tile by default
	var Tile2 = 0;
	{
		// Use a second tile below if current tile width is 0
		if !Height
		{
			Tile2 = +TileSize;
		}
	
		// Use a second tile above if current tile width is 16 and is not a platform tile
		else if Height = TileSize
		{
			if tile_get_index(Tile) < TileAmount
			{
				Tile2 = -TileSize;
			}
		}
	
		// Define if we need to invert the side we're checking at for a second tile 
		var Invert = toPositive ? 1 : -1;
		Tile2     *= Invert;
	
		// Get second tile properties if we're using it
		if Tile2 != 0
		{	
			Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, (Y + Tile2) div TileSize);
			Index  = tile_get_index(Tile) mod TileAmount;
			Height = Game.HeightValueOf[Index][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];
		}
	}
	
	// Return distance
	if noSolidTop and tile_get_index(Tile) > TileAmount
	{
		// Do not collide with platform tiles if we're ignoring them
		return TileSize;
	}
	else
	{
		// Return distance to the edge of our solid tile
		return (Tile2 - (Y mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
	}
}