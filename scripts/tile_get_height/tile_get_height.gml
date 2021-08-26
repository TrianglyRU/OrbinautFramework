/// @function tile_get_height(x,y,tiledata,index)
function tile_get_height(x,y,tiledata,index)
{
	// Get height to use
	if tile_get_mirror(tiledata)
	{
		var HeightToUse = 16 - 1 - x mod 16;
	}
	else
	{
		var HeightToUse = x mod 16;
	}
	
	// Return height
	var Tile = (index - 1) mod Game.TileData[1] + 1;
	return Game.TileHeights[Tile][HeightToUse];
}