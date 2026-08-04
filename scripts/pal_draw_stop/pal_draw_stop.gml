/// @self
/// @description	Disables palette rendering and resets the active palette shader.
function pal_draw_stop()
{
	obj_game.palette_entry_previous = undefined;
	obj_game.palette_entry_current = undefined;
	
	shader_reset();
}