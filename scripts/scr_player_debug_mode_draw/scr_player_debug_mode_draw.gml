/// @function scr_player_draw_debug_mode
function scr_player_draw_debug_mode()
{
	gml_pragma("forceinline");
	
	sprite_index = object_get_sprite(debug_mode_array[debug_mode_ind]);
	image_angle = 0;
	image_index = 0;
	image_alpha = 1.0;
	
	event_inherited();
}
