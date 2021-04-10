/// @function tile_check_collision_h(startX, startY, toPositive, ignoreSolidTop, tileLayer)
function tile_check_collision_h(startX, startY, toPositive, ignoreSolidTop, tileLayer)
{	
	// Initialize return array
	var return_array;
	
	// Return blank values if outside of the room
	if startX < 0 or startY < 0 or startX > room_width or startY > room_height 
	{
		return_array[0] = 31;
		return_array[1] = 360;
		return return_array;
	}
	
	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get tile and read its index
	var Tilemap = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, startY div TileSize);
	var Index   = tile_get_index(Tilemap);	
	
	// Read tile width
	if (ignoreSolidTop and Index < TileAmount) or !ignoreSolidTop
	{
		var Width = tile_get_width(startX, startY, Tilemap, Index mod TileAmount);
	}
	else
	{
		var Width = 0;
	}

	// Use a second tile if first tile width is 0 or 16
	if !Width
	{
		var Tile2 = +TileSize;
	}
	else if Width == TileSize and tile_get_index(Tilemap) <= TileAmount
	{
		var Tile2 = -TileSize;
	}
	else
	{
		var Tile2 = 0;
	}
	Tile2 *= Invert;
	
	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		var Second = tilemap_get(Stage.TileLayer[tileLayer], (startX + Tile2) div TileSize, startY div TileSize);
		if !Tilemap or Second 
		{
			Tilemap = Second;
			Index   = tile_get_index(Tilemap);
			
			if (ignoreSolidTop and Index < TileAmount) or !ignoreSolidTop
			{
				var Width = tile_get_width(startX, startY, Tilemap, Index mod TileAmount);
			}
			else
			{
				var Width = 0;
			}
		}
		else Tile2 = 0;
	}
	
	// Get distance
	return_array[0] = (Tile2 - (startX mod TileSize) + (toPositive ? (TileSize - Width - 1) : Width)) * Invert;

	// Get angle
	if (Index mod TileAmount == 0 or Index mod TileAmount == 1) 
	{
		return_array[1] = toPositive ? 90 : 270;
	}
	else
	{
		var Mirr = tile_get_mirror(Tilemap);
		if toPositive and Mirr 
		{
			return_array[1] =  90;
		}
		else if !toPositive and !Mirr 
		{
			return_array[1] =  270; 
		}
		else
		{
			var Ang = Game.AngleValueOf[Index mod TileAmount];
			if tile_get_flip(Tilemap)
			{
				Ang = (540 - Ang) mod 360;
			}
			return_array[1] =  Mirr ? 360 - Ang : Ang;
		}
	}
	
	// Return data
	return return_array;
}