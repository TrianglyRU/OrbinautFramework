/// @function tile_find_h(x,y,toPositive,ignoreTop,tilelayer)
function tile_find_h(x,y,toPositive,ignoreTop,tilelayer)
{	
	// Floor positions
	x = floor(x);
	y = floor(y);
	
	// If checking to positvie side, subtract 1 from x and y if this object is not the player
	if toPositive and object_index != Player
	{
		x--;
		y--;
	}

	// Return blank values if position we're checking at is outside of the room
	if x <= 0 or y <= 0 or x >= room_width or y >= room_height 
	{
		return [32, noone];
	}
	
	// Get search direction sign
	var SearchDirection = toPositive ? 1 : -1;
	var SearchShift     = 0;
	
	// Get tilelayer ID
	var Layer = Game.TileLayers[tilelayer];
	
	// Get tile at position
	var Tile      = tilemap_get(Layer, x div 16, y div 16);
	var TileIndex = tile_get_index(Tile);
	var TileWidth = tile_get_width(y, Tile, TileIndex);
	
	// If no tile found, get a tile away from the player
	if !TileWidth
	{
		SearchShift = 16;
		Tile        = tilemap_get(Layer, (x + SearchShift * SearchDirection) div 16, y div 16);
		TileIndex   = tile_get_index(Tile);
		TileWidth   = tile_get_width(y, Tile, TileIndex);
	}
	
	// If tile found is the full one, try to find a tile closer to the player
	else if TileWidth == 16
	{
		SearchShift = -16;
		Tile        = tilemap_get(Layer, (x + SearchShift * SearchDirection) div 16, y div 16);
		TileIndex   = tile_get_index(Tile);
		TileWidth   = tile_get_width(y, Tile, TileIndex);
		
		// If no tile has been found, revert back to the initial tile	
		if !TileWidth
		{
			SearchShift = 0;
			Tile        = tilemap_get(Layer, x div 16, y div 16);
			TileIndex   = tile_get_index(Tile);
			TileWidth   = tile_get_width(y, Tile, TileIndex);
		}
	}
	
	// Return blank values if target tile is top-collision tile and we're ignoring it
	if ignoreTop and TileIndex > Game.TileData[1]
	{
		return [32, noone];
	}
	
	// Calculate distance to edge of the found tile
	if toPositive
	{
		var TileDistance = ((x + SearchShift * SearchDirection) & -16) + (16 - TileWidth - 1) - x;
	}
	else
	{
		var TileDistance = x - (((x + SearchShift * SearchDirection) & -16) + TileWidth);
	}
	
	// Get found tile's angle
	var TileAngle = tile_get_angle(TileIndex);

	// Adjust the angle if it is not equal to 360 degrees
	if TileAngle != 360
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