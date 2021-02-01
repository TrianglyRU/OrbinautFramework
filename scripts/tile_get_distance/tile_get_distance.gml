/// @function tile_get_distance_v(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_v(X, Y, Layer, toPositive, onlyFullsolid) 
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
			Hgh = tile_get_height(Tile, Ind, X);
			
			if (Hgh = 0) Diff = 16
			else if (Hgh = 16) Diff = -16;
			else Diff = 0;
		}
	}
	
	if Diff != 0 {
		Diff *= toPositive ? 1 : -1;
		Tile = get_tile(Layer, X, Y + Diff);
		Ind = tile_get_index(Tile) mod 175;
		Hgh = tile_get_height(Tile, Ind, X);
	}
	
	return ((tile_get_flip(Ind) ? Hgh : 16 - Hgh) - (Y mod 16 + 1)) * (toPositive ? 1 : -1) + Diff;
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