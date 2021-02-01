/// @function tile_get_height(tile, index, x)
function tile_get_height(Tile, Ind, X)
{
	return Game.HeightValueOf[Ind][(tile_get_mirror(Tile) ? (15 - X mod 16) : X mod 16)];
}

/// @function tile_get_width(tile, index, y)
function tile_get_width(Tile, Ind, Y)
{
	return Game.WidthValueOf[Ind][(tile_get_flip(Tile) ? (15 - Y mod 16) : Y mod 16)];
}