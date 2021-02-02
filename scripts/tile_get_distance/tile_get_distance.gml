/// @function tile_get_distance_v(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_v(X, Y, Layer, toPositive, onlyFullsolid) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Variables list
	var Tile, Tile2, Height, Index, TileEdge;
	
	// Find tile downwards
	if toPositive
	{	
		// Get tile
		var Tile = tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, Y div TileSize);
		
		// Search for the second tile if the one we got is empty
		if Tile = 0
		{
			Tile2  = +TileSize;
			Index  = 0;
			Height = 0;
		}
		
		// Search for the second tile and use it if needed
		else
		{	
			Index  = tile_get_index(Tile) mod 175;
			Height = tile_get_height(Tile, Index, X);
		
			if Height = TileSize
			{
				Tile2 = -TileSize;
			}
			else if Height = 0
			{
				Tile2 = +TileSize;
			}
			else
			{
				Tile2 = 0;
			}
		}
		if Tile2 != 0
		{	
			Tile   = tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, (Y + Tile2) div TileSize);
			Index  = tile_get_index(Tile) mod 175;
			Height = tile_get_height(Tile, Index, X); 
		}
		
		// Return distance to edge of the tile
		TileEdge = (Y + Tile2) div TileSize * TileSize + (tile_get_flip(Tile) ? -1 : (TileSize - 1 - Height));
		return TileEdge - Y;
	}
	
	// Find tile upwards
	if !toPositive
	{
		// Get tile
		var Tile = tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, Y div TileSize);
		
		// Search for the second tile if the one we got is empty
		if Tile = 0
		{
			Tile2  = -TileSize;
			Index  = 0;
			Height = 0;
		}
		
		// Search for the second tile and use it if needed
		else
		{	
			Index = tile_get_index(Tile) mod 175;
			Height = tile_get_height(Tile, Index, X);
			
			if Height = TileSize
			{
				Tile2 = +TileSize;
			}
			if Height = 0
			{
				Tile2 = -TileSize;
			}
			else
			{
				Tile2 = 0;
			}
		}
		if Tile2 != 0
		{	
			Tile   = tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, (Y + Tile2) div TileSize);
			Index  = tile_get_index(Tile) mod 175;
			Height = tile_get_height(Tile, Index, X); 
		}
		
		// Return distance to edge of the tile
		TileEdge = (Y + Tile2) div TileSize * TileSize + (tile_get_flip(Tile) ? Height : TileSize);
		return Y - TileEdge;
	}	
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