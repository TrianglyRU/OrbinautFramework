/// @function tile_get_angle(index)
function tile_get_angle(index)
{
	return Game.AngleValueOf[index mod TileAmount];
}