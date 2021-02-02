/// @function tile_get_distance_h(x, y, layer, toPositive, onlyFullsolid)
function tile_get_distance_h(X, Y, Layer, toPositive, onlyFullsolid) 
{	
	// Do not perform outside of room boundaries or the game will crash
	if X < 0 or Y < 0 or X > room_width or Y > room_height exit;	

	// Variables list
	var Tile, Tile2, Height, Index, Invert
	
	// Check if we need to invert our calculations
	Invert = toPositive ? 1 : -1;
	
	// Get tile
	Tile = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
		
	// Search for the second tile if the one we got is empty
	if Tile = 0
	{
		Tile2  = +TileSize;
		Index  = 0;
		Height = 0;
	}
		
	// Search for the second tile to the left and to the right, and use it if needed
	else
	{	
		Index  = tile_get_index(Tile) mod 175;
		Height = tile_get_width(Tile, Index, Y);
		
		if Height = TileSize
		{
			Tile2 = -TileSize;
		}
		else if Height = 0
		{
			Tile2 = +TileSize;
		}
		else
		{
			Tile2 = 0;
		}
	}
	if Tile2 != 0
	{	
		Tile2 *= Invert;
		Tile   = tilemap_get(Stage.TileLayer[Layer], (X + Tile2) div TileSize, Y div TileSize)
		Index  = tile_get_index(Tile) mod 175;
		Height = tile_get_width(Tile, Index, Y); 
	}
		
	// Return distance to edge of the tile
	return (Tile2 - (X mod TileSize) + (toPositive ? (TileSize - Height - 1) : Height)) * Invert;
}