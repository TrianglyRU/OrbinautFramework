/// @function tile_get_distance_v(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_v(X, Y, Layer, toPositive, onlyFullsolid) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Variables list
	var Tile, Tile2, Height, Index, Invert
	
	// Check if we need to invert our calculations
	Invert = toPositive ? 1 : -1;
	
	// Get tile and its index
	Tile  = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	Index = tile_get_index(Tile) mod TileAmount;
	
	// Read heightmap
	Height = tile_get_height(Tile, Index, X);
	
	// Use a tile above if this tile height is 16
	if Height = TileSize
	{
		Tile2 = -TileSize;
	}
	
	// Use a tile below if this tile height is 0
	else if Height = 0
	{
		Tile2 = +TileSize;
	}
	
	// Else use current tile
	else
	{
		Tile2 = 0;
	}
	
	// Get second tile properties if we're using it
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], X div TileSize, (Y + Tile2) div TileSize);
		Index  = tile_get_index(Tile) mod 175;
		Height = tile_get_height(Tile, Index, X); 
	}
		
	// Return distance to edge of the tile
	return (Tile2 - (Y mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
}