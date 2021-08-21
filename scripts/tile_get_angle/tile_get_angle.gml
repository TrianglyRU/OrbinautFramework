/// @function tile_get_angle(index)
function tile_get_angle(index)
{
	var Tile = index mod TileAmount;
	if  Tile
	{
		return Game.AngleValueOf[Tile];
	}
	
	// If no tile found, return empty angle
	return noone;
}