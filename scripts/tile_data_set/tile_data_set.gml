/// @function tile_data_set(name,tileAmount,layerA,layerB)
function tile_data_set(name,tileAmount,layerA,layerB)
{
	if name != noone
	{
		if object_index != Framework
		{
			show_debug_message("WARNING: tile_data_set function has been called outside of Framework controller! Skipping...");
		}
		else
		{
			Game.TileData   = [name, tileAmount];
			Game.TileLayers = [layer_tilemap_get_id(layerA), layer_tilemap_get_id(layerB), layerA, layerB];
		}
	}
	else
	{
		Game.TileData   = [];
		Game.TileLayers = [];
	}
}