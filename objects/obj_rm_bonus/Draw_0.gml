var _dx = camera_get_width(view_current) * 0.5;
var _dy = camera_get_height(view_current) * 0.5;

var _title_string = "* BONUS STAGE *";
var _length = string_length(_title_string);

draw_set_font(global.font_data[? spr_font_small]);
draw_set_halign(fa_center);

for (var _i = 0; _i < _length; _i++)
{
    var _offset_x = (_i - round(_length * 0.5)) * 8 + 8;
    var _offset_y = math_oscillate_y(0, obj_game.frame_counter * 4, 2, 1, _i * 48);
	
    draw_text(_dx + _offset_x, 48 + _offset_y, string_char_at(_title_string, _i + 1));
}

draw_text(_dx, _dy - 16, "PRESS ACTION 1 TO RECEIVE 10 RINGS");
draw_text(_dx, _dy - 6, "PRESS ACTION 2 TO GET A RANDOM SHIELD");
draw_text(_dx, _dy + 26, "PRESS START TO LEAVE");
draw_set_halign(fa_left);