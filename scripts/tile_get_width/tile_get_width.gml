/// @function tile_get_width(X, Y, tilemap, index)
function tile_get_width(X, Y, tilemap, index)
{
	if tile_get_flip(tilemap)
	{
		var tileWidth = TileSize - 1 - Y mod TileSize;
	}
	else
	{
		var tileWidth = Y mod TileSize;
	}
	
	if index >= TileAmount
	{
		index += 1;
	}
	
	return Game.WidthValueOf[index mod TileAmount][tileWidth];
}