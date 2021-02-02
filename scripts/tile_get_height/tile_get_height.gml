/// @function tile_get_height(tile, index, x)
function tile_get_height(Tile, Ind, X)
{
	var Column = X mod TileSize;
	return Game.HeightValueOf[Ind][tile_get_mirror(Tile) ? TileSize - 1 - Column : Column];
}