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
	
	if index >= TileAmount
	{
		index += 1;
	}
	return Game.HeightValueOf[index mod TileAmount][heightToUse];
}