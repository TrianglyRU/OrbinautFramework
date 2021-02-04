/// @function tile_get_distance_h(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_h(X, Y, Layer, toPositive, onlyFullsolid) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Variables list
	var Tile, Tile2, Width, Index, Invert
	
	// Check if we need to invert our calculations
	Invert = toPositive ? 1 : -1;
	
	// Get tile and its index
	Tile  = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	Index = tile_get_index(Tile) mod 175;
		
	// Read widthmap
	Width = tile_get_width(Tile, Index, Y);
		
	// Use a tile to the left if this tile width is 16
	if Width = TileSize
	{
		Tile2 = -TileSize;
	}
	
	// Use a tile to the right if this tile width is 0
	else if Width = 0
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
		Tile   = tilemap_get(Stage.TileLayer[Layer], (X + Tile2) div TileSize, Y div TileSize)
		Index  = tile_get_index(Tile) mod 175;
		Width  = tile_get_width(Tile, Index, Y); 
	}
		
	// Return distance to edge of the tile
	return (Tile2 - (X mod TileSize) + (toPositive ? (TileSize - Width - 1) : Width)) * Invert;
}