/// @function tile_get_width(tile, index, y)
function tile_get_width(Tile, Ind, Y)
{
	if tile_get_flip(Tile) = true
	{
		return Game.WidthValueOf[Ind][TileSize - 1 - Y mod TileSize];
	}
	else
	{
		return Game.WidthValueOf[Ind][Y mod TileSize];
	}
}