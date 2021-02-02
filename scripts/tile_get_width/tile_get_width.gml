/// @function tile_get_width(tile, index, y)
function tile_get_width(Tile, Ind, Y)
{
	var Row = Y mod TileSize;
	return Game.WidthValueOf[Ind][tile_get_flip(Tile) ? TileSize - 1 - Row : Row];
}