var _dx = camera_get_width(view_current) * 0.5;
var _dy = camera_get_height(view_current) * 0.5;

draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_center);
draw_text(_dx, _dy - 54, "CONTINUE");

draw_set_font(global.font_data[? spr_font_digits]);
draw_text(_dx + 1, _dy + 7, (time_left >= 600) ? "10" : "0" + string(floor(time_left / 60)));
draw_set_halign(fa_left);

draw_sprite(spr_continue_stars, 0, _dx, _dy + 12);