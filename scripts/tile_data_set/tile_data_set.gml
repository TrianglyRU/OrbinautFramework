/// @function tile_data_set(name,amount,layerA,layerB)
function tile_data_set(name,amount,layerA,layerB)
{
	if object_index != Framework
	{
		show_debug_message("WARNING: tile_dada_set function has been called outside of Framework controller! Skipping...");
	}
	else
	{
		Game.TileData   = [name, amount];
		Game.TileLayers = [layerA, layerB];
	}
}