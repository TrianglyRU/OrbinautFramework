/// @self
/// @description Clears all background data.
function bg_clear_data()
{
	ds_map_destroy(obj_game.bg_data);
	surface_free(obj_game.bg_surface);
	
	obj_game.bg_distance_x = 0;
	obj_game.bg_distance_y = 0;
	obj_game.bg_scroll_x = 0;
	obj_game.bg_scroll_y = 0;
	obj_game.bg_surface = -1;
}