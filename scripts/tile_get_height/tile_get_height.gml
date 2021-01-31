/// @function tile_get_height(tile, index, column)
function tile_get_height(Tile, Ind, Column) 
{
	return Game.HeightValueOf[Ind][(tile_get_mirror(Tile) ? (15 - Column) : Column mod 16)];
}