/// @function tile_get_height(X, Y, tilemap, index)
function tile_get_height(X, Y, tilemap, index)
{
	if tile_get_mirror(tilemap)
	{
		var tileHeight = TileSize - 1 - X mod TileSize;
	}
	else
	{
		var tileHeight = X mod TileSize;
	}
	return Game.HeightValueOf[index][tileHeight];
}