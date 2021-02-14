function tile_get_data_h(X, Y, Layer, toPositive, getData)
{
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get tile and its index
	var Tile  = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index = tile_get_index(Tile) mod TileAmount;
		
	// Read widthmap
	var Width = tile_get_width(Tile, Index, Y);
	
	// Use current tile
	var Tile2 = 0;

	// Use a tile to the right if this tile width is 0
	if !Width
	{
		Tile2 = +TileSize;
	}
	
	// Use a tile to the left if this tile width is 16
	else if !getData and Width = TileSize
	{
		Tile2 = -TileSize;
	}
	
	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], (X + Tile2) div TileSize, Y div TileSize);
		if !getData {
			Index  = tile_get_index(Tile) mod TileAmount;
			Width  = tile_get_width(Tile, Index, Y); 
		}
	}
		
	// Return distance to edge of the tile
	if !getData
	{
		return (Tile2 - (X mod TileSize) + (toPositive ? (TileSize - Width - 1) : Width)) * Invert;
	}
	
	//////////////////////////////////
	
	else
	{	
		if (!Tile) return 360;
		
		if (Tile = 1) return toPositive ? 90 : 270;

		// Get tile properties
	    var Mirr = tile_get_mirror(Tile);
		
		if  toPositive and  Mirr return 90;
		else
		if !toPositive and !Mirr return 270; 
		
		var Flip = tile_get_flip(Tile);
		
		Index = tile_get_index(Tile) mod TileAmount;

	    // Get tile angle based on its range
	    var Ang = Game.AngleValueOf[Index];
    
	    // Adjust the angle if tile is flipped
	    if (Flip) Ang = (540 - Ang) mod 360;
    
	    // Adjust the angle if tile is mirroed and then return it
	    return Mirr ? 360 - Ang : Ang;
	}
}