/// @function tile_meeting(x, y, layer)
function tile_meeting(X, Y, Layer) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or X > room_width exit;
	if Y < 0 or Y > room_height exit;
	
	// Check for the tile
	//var Tile = get_tile(Layer, X, Y);
	var Tile = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize)
	if (Tile == 0) return false;
	
	// Check for its index
	var Ind = tile_get_index(Tile) mod 175;
	if (Ind == 174) return true;
		
	// Return
	var Height = Y mod TileSize;
	return (tile_get_flip(Tile) ? Height : (TileSize - 1 - Height)) < tile_get_height(Tile, Ind, X);
}