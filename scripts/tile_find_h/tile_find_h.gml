/// @function tile_find_h(x,y,toPositive,tilelayer)
function tile_find_h(x,y,toPositive,tilelayer)
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
	var Layer	  = global.TileLayers[tilelayer];
	var Tile      = tilemap_get(Layer, x div 16, y div 16);
	var TileIndex = tile_get_index(Tile);
	var TileWidth = tile_get_width(y, Tile, TileIndex);
	
	// If no width found, get a tile away from the player
	if !TileWidth or tile_ignore_h(TileIndex, toPositive)
	{
		Shift     = 16;
		Tile      = tilemap_get(Layer, (x + Shift * Direction) div 16, y div 16);
		TileIndex = tile_get_index(Tile);
		TileWidth = tile_get_width(y, Tile, TileIndex);
	}
	
	// If width found is 16px, try to find a tile closer to the player
	else if TileWidth == 16
	{
		Shift     = -16;
		Tile      = tilemap_get(Layer, (x + Shift * Direction) div 16, y div 16);
		TileIndex = tile_get_index(Tile);
		TileWidth = tile_get_width(y, Tile, TileIndex);

		// If no width found, revert back to the previous tile	
		if !TileWidth or tile_ignore_h(TileIndex, toPositive)
		{
			Shift     = 0;
			Tile      = tilemap_get(Layer, x div 16, y div 16);
			TileIndex = tile_get_index(Tile);
			TileWidth = tile_get_width(y, Tile, TileIndex);
		}
	}
	
	// If final tile is top solid, ignore it!
	if tile_ignore_h(TileIndex, toPositive)
	{
		return [32, noone];
	}
	
	// Calculate distance to edge of the found tile
	if toPositive
	{
		var TileDistance = ((x + Shift * Direction) & -16) + (16 - TileWidth - 1) - x;
	}
	else
	{
		var TileDistance = x - (((x + Shift * Direction) & -16) + TileWidth);
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
		TileAngle = toPositive ? 90 : 270;
	}
	
	// Return data
	return [TileDistance, TileAngle];
}