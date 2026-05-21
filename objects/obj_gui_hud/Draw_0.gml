var _x = camera_get_x(view_current);
var _y = camera_get_y(view_current);
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);
var _dx, _dy;

draw_set_font(global.font_data[? spr_font_digits]);

_dx = _x + 36 + score_offset;
_dy = _y + 14;

draw_sprite(spr_gui_hud_score, 0, _dx, _dy);
draw_set_halign(fa_right);
draw_text(_dx + 77, _dy - 5, global.score_count);

_dx = _x + 32 + time_offset;
_dy = _y + 30;
	
draw_sprite(spr_gui_hud_time, local_timer < 32400 ? 0 : dynamic_frame, _dx, _dy);
draw_set_halign(fa_left);
draw_text(_dx + 25, _dy - 5, timer_string);

_dx = _x + 36 + rings_offset;
_dy = _y + 46;

draw_sprite(spr_gui_hud_rings, global.player_rings > 0 ? 0 : dynamic_frame, _dx, _dy);	
draw_set_halign(fa_right);
draw_text(_dx + 53, _dy - 5, global.player_rings);

draw_set_font(global.font_data[? spr_font_digits_small]);

_dx = _x + 40 + lives_offset;
_dy = _y + _h - 16;

draw_sprite(spr_gui_hud_lives, view_current > 0 ? global.player_cpu : global.player_main, _dx, _dy);	
draw_set_halign(fa_right);
draw_text(_dx + 25, _dy + 1, global.life_count);
draw_set_halign(fa_left);