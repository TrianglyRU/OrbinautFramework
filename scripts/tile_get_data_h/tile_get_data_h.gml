function tile_get_data_h(X, Y, Layer, toPositive, getData)
{
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Get tile and read its width
	var Tile  = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index = tile_get_index(Tile) mod TileAmount;
	var Width = tile_get_width(Tile, Index, Y);
	
	// Use current tile
	var Tile2 = 0;

	// Use a tile to the right if this tile width is 0
	if !Width
	{
		Tile2 = +TileSize;
	}
	
	// Use a tile to the left if this tile width is 16 and we're checking for the distance
	else if !getData and Width = TileSize
	{
		Tile2 = -TileSize;
	}
	
	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], (X + Tile2) div TileSize, Y div TileSize);
		if !getData 
		{
			Index  = tile_get_index(Tile) mod TileAmount;
			Width  = tile_get_width(Tile, Index, Y); 
		}
	}
	
	// Return distance to the edge of our tile
	if !getData
	{
		return (Tile2 - (X mod TileSize) + (toPositive ? (TileSize - Width - 1) : Width)) * Invert;
	}
	
	// Return angle
	else
	{	
		// Return cardinal angles for empty and full tiles
		if (Tile = 0) return 360;
		if (Tile = 1) return toPositive ? 90 : 270;
		
		// Return cardinal angle for mirrored tiles
	    var Mirr = tile_get_mirror(Tile);
		if toPositive and Mirr 
		{
			return 90;
		}
		else if !toPositive and !Mirr 
		{
			return 270; 
		}
		
		// Get angle of regular tiles
		Index = tile_get_index(Tile) mod TileAmount
	    var Ang = Game.AngleValueOf[Index];
    
	    // Adjust the angle and return it
	    if tile_get_flip(Tile)
		{
			Ang = (540 - Ang) mod 360;
		}
	    return Mirr ? 360 - Ang : Ang;
	}
}