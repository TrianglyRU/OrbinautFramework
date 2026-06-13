htiled = false;
vtiled = false;
factor_x = 0;
factor_y = 0;
width = 0;
height = 0;
tex_width = 0;
tex_height = 0;
scroll_mult_x = 0;
scroll_mult_y = 0;
frame_duration = 0;
line_factor_x = 0;
line_height = -1;
scale_target_y = -1;
scale_target_y_init = -1;

draw_offset_x = 0;
draw_offset_y = 0;
draw_enabled = array_create(VIEW_COUNT, true);

get_draw_x = function(_camera_x, _factor_x)
{
	return floor((_camera_x + obj_game.bg_distance_x) * (1 - _factor_x)) + x - obj_game.bg_distance_x;
}

get_draw_y = function(_camera_y, _factor_y)
{
	return floor((_camera_y + obj_game.bg_distance_y) * (1 - _factor_y)) + y - obj_game.bg_distance_y;
}