/// @function colmask_get_distance(x, y, layer)
function tile_get_distance(X, Y, Layer) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or X > room_width exit;
	if Y < 0 or Y > room_height exit;
	
	X = X div 16;
	Y = Y div 16;
	
	// Check for the tile
	var Tile = tilemap_get(layer_tilemap_get_id(Layer), X, Y);
	if  Tile == 0 
	{
		return false;
	}
		
	// Check for its index
	var Ind = tile_get_index(Tile) mod 175;
	if  Ind == 174
	{
		return true;
	}
		
	// Return
	var ModY = Y mod 16;
	var ModX = X mod 16;
	return (tile_get_flip(Tile) ? ModY : (15 - ModY)) < Game.HeightValueOf[Ind][(tile_get_mirror(Tile) ? (15 - ModX) : ModX)];
}