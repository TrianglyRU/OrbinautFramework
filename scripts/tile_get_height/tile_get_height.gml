/// @function tile_get_height(tile, index, x)
function tile_get_height(Tile, Ind, X)
{
	// Get our position within the tile at x axis
	var Position = X mod TileSize;
	
	// Get height at this position
	return Game.HeightValueOf[Ind][tile_get_mirror(Tile) ? TileSize - 1 - Position : Position];
}