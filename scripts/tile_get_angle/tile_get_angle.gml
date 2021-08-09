/// @function tile_get_angle(index)
function tile_get_angle(index)
{
	var Tile = index mod TileAmount;
	if  Tile
	{
		return Game.AngleValueOf[Tile];
	}
	return noone;
}