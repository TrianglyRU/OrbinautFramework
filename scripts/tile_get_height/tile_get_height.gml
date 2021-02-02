/// @function tile_get_height(tile, index, x)
function tile_get_height(Tile, Ind, X)
{
	if tile_get_mirror(Tile) = true
	{
		return Game.HeightValueOf[Ind][TileSize - 1 - X mod TileSize];
	}
	else
	{
		return Game.HeightValueOf[Ind][X mod TileSize];
	}
}