/// @function tile_check_collision_v(startX, startY, toPositive, ignoreSolidTop, tileLayer)
function tile_check_collision_v(startX, startY, toPositive, ignoreSolidTop, tileLayer)
{
	// Initialize return array
	var return_array;
	
	// Return blank values if outside of the room
	if startX < 0 or startY < 0 or startX > room_width or startY > room_height 
	{
		return_array[0] = 0;
		return_array[1] = 360;
		return return_array;
	}
	
	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get tile and read its height
	var Tilemap = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, startY div TileSize);
	var Index   = tile_get_index(Tilemap) mod TileAmount;
	var Height  = tile_get_height(startX, startY, Tilemap, Index);

	// Use a second tile if first tile height is 0 or 16
	if !Height
	{
		var Tile2 = +TileSize;
	}
	else if Height == TileSize
	{
		if tile_get_index(Tilemap) < TileAmount
		{
			var Tile2 = -TileSize;
		}
	}
	else
	{
		var Tile2 = 0;
	}
	Tile2 *= Invert;

	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		var Second = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, (startY + Tile2) div TileSize);
		if !Tilemap or Second 
		{
			Tilemap = Second;
			Index   = tile_get_index(Tilemap) mod TileAmount;
			Height  = tile_get_height(startX, startY, Tilemap, Index);
		}
		else Tile2 = 0;
	}
	
	// Get distance
	if ignoreSolidTop and tile_get_index(Tilemap) > TileAmount
	{
		return_array[0] = TileSize;
	}
	else
	{
		return_array[0] = (Tile2 - (startY mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
	}
	
	// Get angle
	if (Index == 0 or Index == 1) 
	{
		return_array[1] = toPositive ? 360 : 180;
	}
	else
	{
		var Flip = tile_get_flip(Tilemap);
		if toPositive and Flip 
		{
			return_array[1] = 360;
		}
		else if !toPositive and !Flip 
		{
			return_array[1] = 180;
		}
		else
		{
			var Ang = Game.AngleValueOf[Index];
			if Flip
			{
				Ang = (540 - Ang) mod 360;
			}
			return_array[1] = tile_get_mirror(Tilemap) ? 360 - Ang : Ang;
		}
	}

	// Return data
	return return_array;
}