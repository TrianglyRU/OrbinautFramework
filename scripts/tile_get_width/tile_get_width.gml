/// @function tile_get_width(y,tiledata,index)
function tile_get_width(y,tiledata,index)
{
	if tile_get_flip(tiledata)
	{
		var WidthToUse = 16 - 1 - y mod 16;
	}
	else
	{
		var WidthToUse = y mod 16;
	}	
	var Tile = (index - 1) mod global.TileData[1] + 1;
	
	// Return found width
	return global.TileWidths[Tile][WidthToUse];
}