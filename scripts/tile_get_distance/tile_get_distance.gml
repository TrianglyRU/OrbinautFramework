/// @function tile_get_distance_v(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_v(X, Y, Layer, toPositive, onlyFullsolid) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or X > room_width  exit;
	if Y < 0 or Y > room_height exit;
	
	var Hgh, NextTileIn, Ind;
	
	// Get tiledata of a tile from our collision layer
	var Tiledata = tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, Y div TileSize);

	// If tiledata index is 0, ignore tile index and its height, set distance to the next tile to tilesize
	if Tiledata = 0
	{ 
		NextTileIn = TileSize; 
		Ind = 0; 
		Hgh = 0;
	}
	else
	{	
		// Get index of our tile
		Ind = tile_get_index(Tiledata) mod 175;
		
		// If this is full tile, get the distance to the second tile (above)
		if Ind = 174
		{ 
			NextTileIn = -TileSize;
			Hgh		   = TileSize;
		}
		
		// If our tile is not full
		else 
		{
			// Get tile height
			Hgh = tile_get_height(Tiledata, Ind, X);
			
			// Get distance to the second tile if needed
			if Hgh = 0
			{
				NextTileIn = TileSize;
			}
			else if Hgh = TileSize
			{
				NextTileIn = -TileSize;
			}
			else NextTileIn = 0;
		}
	}

	// If we check for a second tile
	if NextTileIn != 0 
	{	
		// Reverse if we're calculating to the negative Y
		NextTileIn *= toPositive ? 1 : -1;
		
		// Get tiledata of the second tile
		Tiledata = tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, (Y + NextTileIn) div TileSize);
		
		// Get its index and height
		Ind = tile_get_index(Tiledata) mod 175;
		Hgh = tile_get_height(Tiledata, Ind, X);
	}

	// Return distance to the tile we're working with
	return ((tile_get_flip(Ind) ? Hgh : 16 - Hgh) - (Y mod 16 + 1)) * (toPositive ? 1 : -1) + NextTileIn;
	//return (tile_get_mirror(Ind) ? Hgh : 16 - Hgh) - (Y mod 16 + 1) + Diff;
}

/// @function tile_get_distance_h(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_h(X, Y, Layer, toPositive, onlyFullsolid) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or X > room_width  exit;
	if Y < 0 or Y > room_height exit;
	
	var Hgh, Diff, Ind;
	
	// Check for the tile
	var Tile = get_tile(Layer, X, Y);
	
	if Tile = 0
	{ 
		Diff = 16; 
		Ind = 0; 
		Hgh = 0;
	}
	else
	{
		Ind = tile_get_index(Tile) mod 175;
		if Ind = 174
		{ 
			Diff = -16;
			Hgh = 16;
		}
		else 
		{
			Hgh = tile_get_width(Tile, Ind, Y);
			
			if (Hgh = 0) Diff = 16
			else if (Hgh = 16) Diff = -16;
			else Diff = 0;
		}
	}
	
	if Diff != 0 {
		Diff *= toPositive ? 1 : -1;
		Tile = get_tile(Layer, X + Diff, Y);
		Ind = tile_get_index(Tile) mod 175;
		Hgh = tile_get_width(Tile, Ind, Y);
	}
	
	return ((tile_get_flip(Ind) ? Hgh : 16 - Hgh) - (X mod 16 + 1)) * (toPositive ? 1 : -1) + Diff;
	//return (tile_get_mirror(Ind) ? Hgh : 16 - Hgh) - (X mod 16 + 1) + Diff;
}