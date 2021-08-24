/// @function tile_get_width(x,y,tiledata,index)
function tile_get_width(x,y,tiledata,index)
{
	// Get width to use
	if tile_get_flip(tiledata)
	{
		var WidthToUse = TileSize - 1 - y mod TileSize;
	}
	else
	{
		var WidthToUse = y mod TileSize;
	}	
	
	// Return width
	var Tile = (index -1) mod TileAmount + 1;
	return Game.WidthValueOf[Tile][WidthToUse];
}