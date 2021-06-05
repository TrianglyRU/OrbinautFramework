/// @function tile_get_angle(index)
function tile_get_angle(index)
{
	if index >= TileAmount
	{
		index += 1;
	}	
	return Game.AngleValueOf[index mod TileAmount];
}