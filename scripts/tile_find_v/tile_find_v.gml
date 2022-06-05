/// @function tile_find_v(x,y,toPositive,tilelayer)
function tile_find_v(x,y,toPositive,tilelayer)
{	
	x = floor(x);
	y = floor(y);
	
	if toPositive and object_index != Player
	{
		x--;
		y--;
	}
	
	// Exit if no tiledata found
	if !array_length(global.TileData)
	{
		return [32, noone];
	}
	if x < 0 or y < 0 or x > room_width or y > room_height 
	{
		return [32, noone];
	}
	
	var Direction = toPositive ? 1 : -1;
	var Shift     = 0;
	
	// Get tile at position
	var Layer	   = global.TileLayers[tilelayer];
	var Tile       = tilemap_get(Layer, x div 16, y div 16);
	var TileIndex  = tile_get_index(Tile);
	var TileHeight = tile_get_height(x, Tile, TileIndex);
	
	// If no height found, get a tile away from the player
	if !TileHeight or tile_ignore_v(TileIndex, toPositive)
	{
		Shift		= 16;
		Tile	    = tilemap_get(Layer, x div 16, (y + Shift * Direction) div 16);
		TileIndex   = tile_get_index(Tile);
		TileHeight  = tile_get_height(x, Tile, TileIndex);
	}
	
	// If height found is 16px, try to find a tile closer to the player
	else if TileHeight == 16
	{
		Shift		= -16;
		Tile        = tilemap_get(Layer, x div 16, (y + Shift * Direction) div 16);
		TileIndex   = tile_get_index(Tile);
		TileHeight  = tile_get_height(x, Tile, TileIndex);
		
		// If no height found, revert back to the previous tile	
		if !TileHeight or tile_ignore_v(TileIndex, toPositive)
		{
			Shift		= 0;
			Tile        = tilemap_get(Layer, x div 16, y div 16);
			TileIndex   = tile_get_index(Tile);
			TileHeight  = tile_get_height(x, Tile, TileIndex);
		}
	}
	
	// If final tile is top solid and we're checking upwards or outside the room, ignore it!
	if tile_ignore_v(TileIndex, toPositive) or (y + Shift * Direction) & -16 >= room_height
	{
		return [32, noone];
	}
	
	// Calculate distance to edge of the found tile
	if toPositive
	{
		var TileDistance = ((y + Shift * Direction) & -16) + (16 - TileHeight - 1) - y;
	}
	else
	{
		var TileDistance = y - (((y + Shift * Direction) & -16) + TileHeight);
	}
	
	
	// Get angle
	var TileAngle  = tile_get_angle(TileIndex);
	if  TileAngle != 360
	{
		if tile_get_flip(Tile)
		{
			TileAngle = (540 - TileAngle) mod 360;
		}
		if tile_get_mirror(Tile)
		{
			TileAngle = 360 - TileAngle;
		}
	}
	else
	{
		TileAngle = toPositive ? 360 : 180;
	}
	
	// Return data
	return [TileDistance, TileAngle];
}