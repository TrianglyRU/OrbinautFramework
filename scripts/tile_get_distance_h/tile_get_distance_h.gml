/// @function tile_get_distance_h(X, Y, toPositive, noSolidTop, Layer)
function tile_get_distance_h(X, Y, toPositive, noSolidTop, Layer)
{	
	// Do not perform outside of the room
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Get tile and read its width
	var Tile  = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index = tile_get_index(Tile) mod TileAmount;
	var Width = Game.WidthValueOf[Index][tile_get_flip(Tile) ? TileSize - 1 - Y mod TileSize : Y mod TileSize];
	
	// Do not use second tile by default
	var Tile2 = 0;
	{
		// Use a second tile to the right if current tile width is 0
		if !Width
		{
			Tile2 = +TileSize;
		}
	
		// Use a second tile to the left if current tile width is 16 and is not a platform tile
		else if Width = TileSize 
		{
			if tile_get_index(Tile) <= TileAmount
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
			Tile   = tilemap_get(Stage.TileLayer[Layer], (X + Tile2) div TileSize, Y div TileSize);
			Index  = tile_get_index(Tile) mod TileAmount;
			Width  = Game.WidthValueOf[Index][tile_get_flip(Tile) ? TileSize - 1 - Y mod TileSize : Y mod TileSize];
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
		return (Tile2 - (X mod TileSize) + (toPositive ? (TileSize - Width - 1) : Width)) * Invert;
	}
}