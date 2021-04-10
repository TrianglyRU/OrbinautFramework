/// @function tile_check_collision_v(startX, startY, toPositive, ignoreSolidTop, tileLayer)
function tile_check_collision_v(startX, startY, toPositive, ignoreSolidTop, tileLayer)
{	
	// Return blank values if outside of the room
	if startX < 0 or startY < 0 or startX > room_width or startY > room_height 
	{
		return [32, 360];
	}
	
	// Initialize return array
	var return_array;
	
	// Check if we need to invert our calculations
	var Invert = toPositive ? 1 : -1;
	
	// Get tile and read its index
	var Tilemap = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, startY div TileSize);
	var Index   = tile_get_index(Tilemap);
	
	// Read tile height
	if ignoreSolidTop and Index >= TileAmount
	{
		var Height = 0;
	}
	else
	{
		var Height = tile_get_height(startX, startY, Tilemap, Index mod TileAmount);
	}

	// Use a second tile if first tile height is 0 or 16
	var Tile2;
	switch Height
	{
		case 0:		   Tile2 = +TileSize; break;
		case TileSize: Tile2 = -TileSize; break;
		default:	   Tile2 = 0;         break;
	}
	Tile2 *= Invert;

	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		var Second = tilemap_get(Stage.TileLayer[tileLayer], startX div TileSize, (startY + Tile2) div TileSize);
		if !Tilemap or Second 
		{
			Tilemap = Second;
			Index   = tile_get_index(Tilemap);
			
			if (ignoreSolidTop and Index < TileAmount) or !ignoreSolidTop
			{
				var Height = tile_get_height(startX, startY, Tilemap, Index mod TileAmount);
			}
			else
			{
				var Height = 0;
			}
		}
		else Tile2 = 0;
	}
	
	// Get distance
	return_array[0] = (Tile2 - (startY mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
	
	// Get angle
	Index = Index mod TileAmount;
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