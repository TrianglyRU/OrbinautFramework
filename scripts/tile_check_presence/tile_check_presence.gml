/// @function tile_check_presence(x,y,ignore_top,tilelayer)
function tile_check_presence(x,y,ignore_top,tilelayer)
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
	var Layer = layer_tilemap_get_id(Game.TileLayers[tilelayer]);
    
    // Check for the tile
    var Tile = tilemap_get(Layer, x div 16, y div 16);
    
    // Check for its index
    var Index = tile_get_index(Tile);
	
    // Return false if it is solidtop and we're ignoring them
    if ignore_top and Index > Game.TileData[1]
    {
        return false;
    }
        
    // Get position within the tile and tile height
    var TilePosition = y mod 16;
    var TileHeight   = tile_get_height(x, y, Tile, Index);

    // Return result
	if tile_get_flip(Tile)
	{
		return TilePosition < TileHeight;
	}
	else
	{
		return 16 - 1 - TilePosition < TileHeight;
	}
}