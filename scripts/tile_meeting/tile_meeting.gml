/// @function tile_meeting(x, y, layer)
function tile_meeting(X, Y, Layer) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or X > room_width exit;
	if Y < 0 or Y > room_height exit;
	
	// Check for the tile
	var Tile = tilemap_get(layer_tilemap_get_id(Layer), X div 16, Y div 16);
	if  Tile == 0 
	{
		return false;
	}
		
	// Check for its index
	var Ind = tile_get_index(Tile);
	if  Ind == 247 
	{
		return true;
	}
		
	// Return
	var ModY = Y mod 16, 
	var ModX = X mod 16;
	return (Game.IsCeilingOf[Ind] ? ModY : (15 - ModY)) < Game.HeightValueOf[Ind][(tile_get_mirror(Tile) ? (15 - ModX) : ModX)];
}