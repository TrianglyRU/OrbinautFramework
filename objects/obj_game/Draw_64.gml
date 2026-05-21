/// @description Draw Debug Overlay
if room == rm_startup || global.debug_framework == 0
{
	return;
}

var _w = display_get_gui_width();
var _x = _w - 120;
var _max_x = _w - 8;

draw_set_alpha(0.75);
draw_rectangle_colour(_x, 8, _max_x, 32, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

draw_set_font(global.font_data[? spr_font_system]);
draw_set_halign(fa_left);

draw_text(_x, 8,  "STATE: " + debug_get_state_name());
draw_text(_x, 16, "OBJ:   " + string(instance_number(obj_gameobject)) + " " + string(instance_count));
draw_text(_x, 24, "FPS:   " + string(fps) + " " + string(floor(fps_real)));

if global.debug_framework != 2
{
	return;
}

var _count = instance_number(obj_gameobject);

if _count == 0
{
	return;
}

draw_set_alpha(0.75);
draw_rectangle_colour(_x, 40, _w - 8, 40 + _count * 8, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

var _i = 0;

with obj_gameobject
{
	draw_text(_x, 40 + _i++ * 8, string_copy(object_get_name(object_index), 1, (_max_x - _x) / 8));
}