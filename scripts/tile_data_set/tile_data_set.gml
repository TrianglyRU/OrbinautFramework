/// @function tile_data_set(name,amount,layerA,layerB)
function tile_data_set(name,amount,layerA,layerB)
{
	Game.TileData   = [name, amount];
	Game.TileLayers = [layerA, layerB];	
}