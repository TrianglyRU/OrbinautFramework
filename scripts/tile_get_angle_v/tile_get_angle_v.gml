/// @function tile_get_angle_v(X, Y, toPositive, noSolidTop, Layer)
function tile_get_angle_v(X, Y, toPositive, noSolidTop, Layer)
{
	// Return angle value of 360 if we're out of stage boundaries
	if (X < 0 or Y < 0 or X > room_width or Y > room_height) return 360;	

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
	
	// Use a tile above if this tile height is 16 and we're checking for the distance
	else if Height = TileSize
	{
		if !noSolidTop
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
		Index  = tile_get_index(Tile) mod TileAmount;
		Height = Game.HeightValueOf[Index][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];

	}

	// Return cardinal angle for empty tile
	if (!Tile) return toPositive ? 360 : 180;
		
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