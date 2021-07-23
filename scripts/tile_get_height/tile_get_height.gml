/// @function tile_get_height(x,y,tiledata,index)
function tile_get_height(x, y, tiledata, index)
{
	if tile_get_mirror(tiledata)
	{
		var HeightToUse = TileSize - 1 - x mod TileSize;
	}
	else
	{
		var HeightToUse = x mod TileSize;
	}
	
	return Game.HeightValueOf[index mod TileAmount][HeightToUse];
}