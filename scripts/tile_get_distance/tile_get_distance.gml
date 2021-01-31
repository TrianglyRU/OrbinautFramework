/// @function colmask_get_distance(x, y, layer)
function tile_get_distance(X, Y, Layer) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or X > room_width  exit;
	if Y < 0 or Y > room_height exit;
	
	// Check for the tile
	var Tile = tilemap_get(Stage.TargetTileLayer[Layer], X div 16, Y div 16);
	var Ind = tile_get_index(Tile) mod 175;
	var Hgh = tile_get_height(Tile, Ind, X);
	var Diff;
	
	if Hgh = 0
	{
		Tile = get_tile(Layer, X, Y + 1);
		Diff = 16;
	} 
	else if Hgh = 16 
	{
		Tile = get_tile(Layer, X, Y - 1);
		Diff = -16;
	} 
	else
	{
		Diff = 0;
	}
	
	if Hgh = 0 or Hgh = 16 {
		Ind = tile_get_index(Tile) mod 175;
		Hgh = tile_get_height(Tile, Ind, X);
	}
	
	return (tile_get_flip(Ind) ? Hgh : 16 - Hgh) - (Y mod 16 + 1) + Diff;
	//return (tile_get_flip(Ind) ? Hgh : 16 - Hgh) + (Y div 16 * 16 - Y - 1) + Diff;
}