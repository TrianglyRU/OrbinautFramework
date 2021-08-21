/// @function tile_get_width(x,y,tiledata,index)
function tile_get_width(x,y,tiledata,index)
{
	if tile_get_flip(tiledata)
	{
		var WidthToUse = TileSize - 1 - y mod TileSize;
	}
	else
	{
		var WidthToUse = y mod TileSize;
	}	
	return Game.WidthValueOf[index mod TileAmount][WidthToUse];
}