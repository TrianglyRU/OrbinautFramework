/// @function tile_get_height(x,tiledata,index)
function tile_get_height(x,tiledata,index)
{
	if tile_get_mirror(tiledata)
	{
		var HeightToUse = 16 - 1 - x mod 16;
	}
	else
	{
		var HeightToUse = x mod 16;
	}
	var Tile = (index - 1) mod Game.TileData[1] + 1;
	
	// Return found height
	return Game.TileHeights[Tile][HeightToUse];
}