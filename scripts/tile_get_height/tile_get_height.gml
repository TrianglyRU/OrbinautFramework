/// @function tile_get_height(x,y,tiledata,index)
function tile_get_height(x,y,tiledata,index)
{
	// Get height to use
	if tile_get_mirror(tiledata)
	{
		var HeightToUse = TileSize - 1 - x mod TileSize;
	}
	else
	{
		var HeightToUse = x mod TileSize;
	}
	
	// Return height
	var Tile = (index - 1) mod TileAmount + 1;
	return Game.HeightValueOf[Tile][HeightToUse];
}