var _x = camera_get_x(view_current);
var _y = camera_get_y(view_current);
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);
var _centre_x = _x + _w * 0.5;
var _centre_y = _y + _h * 0.5;
var _factor_x = _w / 320;
var _factor_y = _h / 224;
var _dx, _dy;

draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_right);

_dx = _centre_x - 64;
_dy = _centre_y - 24 + offset_banner * _factor_y;

draw_sprite(spr_gui_card_banner, 0, _dx, _dy);

_dx = _centre_x + 129 + offset_zonename * _factor_x;
_dy = _centre_y - 26;

draw_text(_dx, _dy, obj_rm_stage.zone_name);

_dx = _centre_x + 104 + offset_zone * _factor_x;
_dy = _centre_y - 4;

draw_text(_dx, _dy, "ZONE");

_dx = _centre_x + 117 + offset_act * _factor_x;
_dy = _centre_y + 12;
	
draw_sprite(spr_gui_act, obj_rm_stage.act_index, _dx, _dy);
draw_set_halign(fa_left);