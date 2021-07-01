/// @function tile_meeting(x, y, layer)
function tile_meeting(X, Y, Layer) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height 
	{
		exit;
	}
	
	// Check for the tile
	var Tile = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize)
	if (Tile == 0) return false;
	
	// Check for its index
	var Ind = tile_get_index(Tile) mod TileAmount;
	if (Ind == 1) return true;
		
	// Get position within the tile and tile height
	var TilePosition = Y mod TileSize;
	var TileHeight   = Game.HeightValueOf[Ind][tile_get_mirror(Tile) ? TileSize - 1 - X mod TileSize : X mod TileSize];
	
	// Return result
	return (tile_get_flip(Tile) ? TilePosition : (TileSize - 1 - TilePosition)) < TileHeight;
}