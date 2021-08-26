/// @function tile_get_width(x,y,tiledata,index)
function tile_get_width(x,y,tiledata,index)
{
	// Get width to use
	if tile_get_flip(tiledata)
	{
		var WidthToUse = 16 - 1 - y mod 16;
	}
	else
	{
		var WidthToUse = y mod 16;
	}	
	
	// Return width
	var Tile = (index - 1) mod Game.TileData[1] + 1;
	return Game.TileWidths[Tile][WidthToUse];
}