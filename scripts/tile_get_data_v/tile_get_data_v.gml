function tile_get_data_v(X, Y, Layer, toPositive, getData)
{
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Get tile and read its height
	var Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index  = tile_get_index(Tile) mod TileAmount;
	var Height = tile_get_height(Tile, Index, X);
	
	// Use current tile
	var Tile2 = 0;

	// Use a tile below if this tile height is 0
	if !Height
	{
		Tile2 = +TileSize;
	}
	
	// Use a tile above if this tile height is 16 and we're checking for the distance
	else if !getData and Height = TileSize
	{
		Tile2 = -TileSize;
	}
	
	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, (Y + Tile2) div TileSize);
		if !getData 
		{
			Index  = tile_get_index(Tile) mod TileAmount;
			Height = tile_get_height(Tile, Index, X); 
		}
	}
		
	// Return distance to the edge of our tile
	if !getData
	{
		return (Tile2 - (Y mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
	}

	// Return angle
	else
	{	
		// Use default angle for empty tile
		if (!Tile) return 360;
		
		// Return cardinal angle for flipped tiles
		var Flip = tile_get_flip(Tile);
		if toPositive and Flip 
		{
			return 360;
		}
		else if !toPositive and !Flip 
		{
			return 180;
		}
		
		// Get angle of regular tiles
		Index = tile_get_index(Tile) mod TileAmount;
	    var Ang = Game.AngleValueOf[Index];
    
		// Adjust the angle and return it
	    if Flip
		{
			Ang = (540 - Ang) mod 360;
		}
	    return tile_get_mirror(Tile) ? 360 - Ang : Ang;
	}
}