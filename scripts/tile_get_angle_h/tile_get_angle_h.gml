/// @function tile_get_angle_h(X, Y, toPositive, noSolidTop, Layer)
function tile_get_angle_h(X, Y, toPositive, noSolidTop, Layer)
{
	// Return angle value of 360 if we're out of stage boundaries
	if (X < 0 or Y < 0 or X > room_width or Y > room_height) return 360;	

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
		
	// Return cardinal angles for empty and full tiles
	if (Tile = 0 or Tile = 1) return toPositive ? 90 : 270;
		
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
	var Ang = Game.AngleValueOf[Index];
    
	// Adjust the angle and return it
	if tile_get_flip(Tile)
	{
		Ang = (540 - Ang) mod 360;
	}
	return Mirr ? 360 - Ang : Ang;
}