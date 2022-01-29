/// @function tile_find_h(x,y,toPositive,ignoreTop,tilelayer)
function tile_find_h(x,y,toPositive,ignoreTop,tilelayer)
{	
	// Floor positions
	x = floor(x);
	y = floor(y);
	
	// Subtract 1 if we're not the player
	if toPositive and object_index != Player
	{
		x--;
		y--;
	}

	// Exit if outside of the room
	if x <= 0 or y <= 0 or x >= room_width or y >= room_height 
	{
		return [32, noone];
	}
	
	var Direction = toPositive ? 1 : -1;
	var Shift     = 0;
	
	// Get tile at position
	var Layer	  = Game.TileLayers[tilelayer];
	var Tile      = tilemap_get(Layer, x div 16, y div 16);
	var TileIndex = tile_get_index(Tile);
	var TileWidth = tile_get_width(y, Tile, TileIndex);
	
	// If no width found, get a tile away from the player
	if !TileWidth
	{
		Shift		= 16;
		Tile        = tilemap_get(Layer, (x + Shift * Direction) div 16, y div 16);
		TileIndex   = tile_get_index(Tile);
		TileWidth   = tile_get_width(y, Tile, TileIndex);
	}
	
	// If width found is 16px, try to find a tile closer to the player
	else if TileWidth == 16
	{
		Shift		= -16;
		Tile        = tilemap_get(Layer, (x + Shift * Direction) div 16, y div 16);
		TileIndex   = tile_get_index(Tile);
		TileWidth   = tile_get_width(y, Tile, TileIndex);
		
		// If no width found, revert back to the previous tile	
		if !TileWidth
		{
			Shift		= 0;
			Tile        = tilemap_get(Layer, x div 16, y div 16);
			TileIndex   = tile_get_index(Tile);
			TileWidth   = tile_get_width(y, Tile, TileIndex);
		}
	}
	
	// Exit if tile is top-only and we're ignoring them
	if ignoreTop and TileIndex > Game.TileData[1]
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