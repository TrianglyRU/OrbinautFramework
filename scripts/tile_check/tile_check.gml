/// @function tile_check(x,y,ignoreTop,tilelayer)
function tile_check(x,y,ignoreTop,tilelayer)
{
	// Floor positions
	x = floor(x);
	y = floor(y);
	
	// Return false if outside of the room
    if x <= 0 or y <= 0 or x >= room_width or y >= room_height 
    {
        return false;
    }
	
	// Get tilelayer ID
	var Layer = Game.TileLayers[tilelayer];
    
    // Check for the tile
    var Tile      = tilemap_get(Layer, x div 16, y div 16);
    var TileIndex = tile_get_index(Tile);
	
    // Return false if it is solidtop and we're ignoring them
    if ignoreTop and TileIndex > Game.TileData[1]
    {
        return false;
    }
  
    // Return result
	if tile_get_flip(Tile)
	{
		return y mod 16 < tile_get_height(x, Tile, TileIndex);
	}
	else
	{
		return 16 - 1 - y mod 16 < tile_get_height(x, Tile, TileIndex);
	}
}