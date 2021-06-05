/// @function tile_get_height(X, Y, tilemap, index)
function tile_get_height(X, Y, tilemap, index)
{
	if tile_get_mirror(tilemap)
	{
		var heightToUse = TileSize - 1 - X mod TileSize;
	}
	else
	{
		var heightToUse = X mod TileSize;
	}
	return Game.HeightValueOf[index][heightToUse];
}