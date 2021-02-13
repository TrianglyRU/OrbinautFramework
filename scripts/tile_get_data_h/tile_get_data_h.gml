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
		
	// Use a tile to the left if this tile width is 16
	if Width = TileSize
	{
		var Tile2 = -TileSize;
	}
	
	// Use a tile to the right if this tile width is 0
	else if Width = 0
	{
		var Tile2 = +TileSize;
	}
	
	// Else use current tile
	else
	{
		var Tile2 = 0;
	}

	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], (X + Tile2) div TileSize, Y div TileSize)
		Index  = tile_get_index(Tile) mod TileAmount;
		Width  = tile_get_width(Tile, Index, Y); 
	}
		
	// Return distance to edge of the tile
	if getData = 0
	{
		return (Tile2 - (X mod TileSize) + (toPositive ? (TileSize - Width - 1) : Width)) * Invert;
	}
	
	//////////////////////////////////
	
	if getData = 1
	{
		var Range = round(Angle/90) % 4;
	    if (Index = 1) return Range * 90;
    
	    // Get tile properties
	    var Flip = tile_get_flip(Tile);
	    var Mirr = tile_get_mirror(Tile);
    
	    // Get angle range of the tile based on its properties
	    if Grounded
	    {        
	        if (Range mod 2) and Mirr or !(Range mod 2) and Flip
	        {
	            Range = (Range + 2) mod 4;
	        }
	    }
	    else
	    {
	        Range = 0;
	    }
    
	    // Get tile angle based on its range
	    var Ang = Game.AngleValueOf[Index][Range];
    
	    // Adjust the angle if tile is flipped
	    if (Flip) Ang = (540 - Ang) mod 360;
    
	    // Adjust the angle if tile is mirroed and then return it
	    return Mirr ? 360 - Ang : Ang;
	}
}