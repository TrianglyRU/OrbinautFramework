/// @function tile_check_collision_v(x,y,toPositive,ignoreTop,tilelayer)
function tile_check_collision_v(x,y,toPositive,ignoreTop,tilelayer)
{	
	// Floor positions
	x = floor(x);
	y = floor(y);
	
	// If checking to positvie side, subtract 1 from x and y if this object is not player
	if toPositive and object_index != Player
	{
		x--;
		y--;
	}
	
	// Return blank values if outside of the room
	if x <= 0 or y <= 0 or x >= room_width or y >= room_height 
	{
		return [32, 360];
	}
	
	// Get tilelayer ID
	var Layer = layer_tilemap_get_id(Game.TileLayers[tilelayer]);
	
	// Set search direction sign
	var SearchDirection = toPositive ? 1 : -1;
	
	// Get first tile
	var FirstTile       = tilemap_get(Layer, x div 16, y div 16);
	var FirstTileIndex  = tile_get_index(FirstTile);
	var FirstTileHeight = tile_get_height(x, y, FirstTile, FirstTileIndex);
	
	// Ignore first tile if it is solidtop and we're ignoring them
	if ignoreTop and FirstTileIndex > Game.TileData[1]
	{
		FirstTileHeight = 0;
	}
	
	// If first tile height is in range of [1, 15], use this tile
	if FirstTileHeight != 0 and FirstTileHeight != 16
	{
		var SearchShift     = 0;
		var ResultTile      = FirstTile;
		var ResultTileIndex = FirstTileIndex;
	}
	
	// If first tile height is 0, use a tile below
	else if FirstTileHeight == 0
	{
		var SearchShift     = 16;
		var ResultTile      = tilemap_get(Layer, x div 16, (y + SearchShift * SearchDirection) div 16);
		var ResultTileIndex = tile_get_index(ResultTile);
	}
	
	// If first tile height is 16, get a tile above
	else
	{
		var SearchShift      = -16;
		var SecondTile       = tilemap_get(Layer, x div 16, (y + SearchShift * SearchDirection) div 16);
		var SecondTileIndex  = tile_get_index(SecondTile);
		var SecondTileHeight = tile_get_height(x, y, SecondTile, SecondTileIndex);
		
		// Ignore second tile if it is solidtop and we're ignoring them
		if ignoreTop and SecondTileIndex > Game.TileData[1]
		{
			SecondTileHeight = 0;
		}
		
		// Test if second tile height is 0		
		if !SecondTileHeight
		{
			// If it is, use first tile
			var SearchShift     = 0
			var ResultTile      = FirstTile;
			var ResultTileIndex = FirstTileIndex;
		}
		else
		{
			// If it is not, use second tile
			var ResultTile      = SecondTile;
			var ResultTileIndex = SecondTileIndex;
		}
	}
	
	// Return blank values if target tile is outside of the room
	var BoundsCheck = (y + SearchShift * SearchDirection) div 16 * 16;
	if  BoundsCheck >= room_height
	{
		return [32, 360];
	}
		
	// Get result tile height
	var ResultHeight = tile_get_height(x, y, ResultTile, ResultTileIndex);
	
	// Ignore result tile if it is solidtop and we're ignoring them
	if ignoreTop and ResultTileIndex > Game.TileData[1]
	{
		ResultHeight = 0;
	}
		
	// Calculate distance to edge of the result tile
	if toPositive
	{
		var TileDistance = (y + SearchShift * SearchDirection) div 16 * 16 + (16 - ResultHeight - 1) - y;
	}
	else
	{
		var TileDistance = y - ((y + SearchShift * SearchDirection) div 16 * 16 + ResultHeight);
	}
	
	// Get tile angle
	var TileAngle = tile_get_angle(ResultTileIndex);
	
	// Adjust angle if it is not 360 degrees
	if TileAngle != 360
	{
		// Flip angle if tile is flipped
		if tile_get_flip(ResultTile)
		{
			TileAngle = (540 - TileAngle) mod 360;
		}
		
		// Mirror angle if tile is mirrored
		if tile_get_mirror(ResultTile)
		{
			TileAngle = 360 - TileAngle;
		}
	}
	else
	{
		// Get cardinal angle based on direction
		TileAngle = toPositive ? 360 : 180;
	}
	
	// Return data
	return [TileDistance, TileAngle];
}