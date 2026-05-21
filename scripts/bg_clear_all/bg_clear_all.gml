/// @self
/// @description Removes all background objects and the temporary layers they occupy.
function bg_clear_all()
{
	with obj_layer
	{
		instance_destroy();
	}
	
	with obj_game
	{
		bg_distance_x = 0;
		bg_distance_y = 0;
		bg_scroll_x = 0;
		bg_scroll_y = 0;
	}
}