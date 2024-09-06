// Disable fade effect
draw_toggle_fade(false);

var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);
var _camera_x = camera_get_x(view_current) + _width / 2;
var _camera_y = camera_get_y(view_current) + _height / 2;
var _factor_x = _width / 320;
var _factor_y = _height / 224;

// Draw the banner
var _x = _camera_x - 64;
var _y = _camera_y - 24 + offset_banner * _factor_y;
draw_sprite(spr_gui_card_banner, 0, _x, _y);

// Draw the zone name
_x = _camera_x + 129 + offset_zonename * _factor_x;
_y = _camera_y - 26;

draw_set_font(global.font_large);
draw_set_halign(fa_right);
draw_text(_x, _y, c_stage.zone_name);

// Draw the "ZONE" label
_x = _camera_x + 104 + offset_zone * _factor_x;
_y = _camera_y - 4;

draw_text(_x, _y, "ZONE");

// Draw the act number sprite
_x = _camera_x + 117 + offset_act * _factor_x;
_y = _camera_y + 12;

draw_sprite(spr_gui_act, c_stage.act_id, _x, _y);

// Re-enable fade effect
draw_toggle_fade(true);