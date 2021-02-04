/// @function tile_get_width(tile, index, y)
function tile_get_width(Tile, Ind, Y)
{
	// Get our position within the tile at y axis
	var Position = Y mod TileSize;
	
	// Get width at this position
	return Game.WidthValueOf[Ind][tile_get_flip(Tile) ? TileSize - 1 - Position : Position];
}