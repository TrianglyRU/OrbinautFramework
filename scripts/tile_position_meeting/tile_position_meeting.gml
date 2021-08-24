/// @function tile_position_meeting(x,y,ignore_top,layer)
function tile_position_meeting(x,y,ignore_top,layer)
{
	// Floor positions
	x = floor(x);
	y = floor(y);
	
	// Return false if outside of the room
    if x <= 0 or y <= 0 or x >= room_width or y >= room_height 
    {
        return false;
    }
    
    // Check for the tile
    var Tile = tilemap_get(Stage.TileLayer[layer], x div TileSize, y div TileSize);
    
    // Check for its index
    var Index = tile_get_index(Tile);
    
    // Return false if it is solidtop and we're ignoring them
    if ignore_top and Index > TileAmount
    {
        return false;
    }
        
    // Get position within the tile and tile height
    var TilePosition = y mod TileSize;
    var TileHeight   = tile_get_height(x, y, Tile, Index);

    // Return result
    return (tile_get_flip(Tile) ? TilePosition : (TileSize - 1 - TilePosition)) < TileHeight;
}