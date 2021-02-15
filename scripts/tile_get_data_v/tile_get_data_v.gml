/// @function tile_get_data_v(X, Y, Layer, toPositive, dataToGet, noSolidTop)
function tile_get_data_v(X, Y, Layer, toPositive, dataToGet, noSolidTop)
{
	// Report script error
	if dataToGet != "data_distance" and dataToGet != "data_angle"
	{
		show_message("Wrong dataToGet attribute set in function tile_get_data_v. Expected 'data_distance' or 'data_angle', got " + string(dataToGet));
		game_end();
	}
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
	
	// Use a tile above if this tile height is 16 
	else if Height = TileSize
	{
		if dataToGet = "data_distance" and !noSolidTop
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
		if dataToGet = "data_distance"
		{
			Index  = tile_get_index(Tile) mod TileAmount;
			Height = Game.HeightValueOf[Index][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];
		}
	}
		
	// Return distance to the edge of our tile
	if dataToGet = "data_distance"
	{
		if noSolidTop and tile_get_index(Tile) > TileAmount
		{
			return TileSize;
		}
		else
		{
			return (Tile2 - (Y mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
		}
	}

	// Return angle
	if dataToGet = "data_angle"
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
		Index   = tile_get_index(Tile) mod TileAmount;
	    var Ang = Game.AngleValueOf[Index];
    
		// Adjust the angle and return it
	    if Flip
		{
			Ang = (540 - Ang) mod 360;
		}
	    return tile_get_mirror(Tile) ? 360 - Ang : Ang;
	}
}