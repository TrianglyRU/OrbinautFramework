/// @function tile_meeting(x, y, layer)
function tile_meeting(X, Y, Layer) 
{	
	// Check for tile
	var Tile = tilemap_get(layer_tilemap_get_id(Layer), X div 16, Y div 16);
	if  Tile == 0 {
		return false;
	}
		
	// Check for its index
	var Ind = tile_get_index(Tile);
	if  Ind == 247 {
		return true;
	}
		
	// Return
	var ModY = Y mod 16, ModX = X mod 16;
	return (Game.IsCeilingOf[Ind] ? ModY : (15 - ModY)) < Game.HeightValueOf[Ind][(tile_get_mirror(Tile) ? (15 - ModX) : ModX)];
}