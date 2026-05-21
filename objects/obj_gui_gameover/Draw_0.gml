var _x = camera_get_x(view_current);
var _y = camera_get_y(view_current);
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);

var _dx = _x + _w * 0.5;
var _dy = _y + _h * 0.5;
var _factor_x = _w / 320;

draw_sprite(spr_gui_gameover_left, image_index, _dx - offset_x * _factor_x, _dy);
draw_sprite(spr_gui_gameover_right, 0, _dx + offset_x * _factor_x, _dy);