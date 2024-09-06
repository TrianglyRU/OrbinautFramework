var _half_width = camera_get_width(view_current) / 2;
var _half_height = camera_get_height(view_current) / 2;
var _title_string = "* BONUS STAGE *";
var _length = string_length(_title_string);

// Set drawing properties
draw_set_font(global.font_small);
draw_set_halign(fa_center);

// Draw title string with oscillation effect
for (var i = 0; i < _length; i++)
{
    var _offset_x = (i - round(_length / 2)) * 8 + 8;
    var _offset_y = obj_oscillate_y(0, c_framework.frame_counter * 4, 2, 1, i * 48);
    draw_text(_half_width + _offset_x, 48 + _offset_y, string_char_at(_title_string, i + 1));
}

// Draw instructions
draw_text(_half_width, _half_height - 16, "PRESS ACTION 1 TO RECEIVE 10 RINGS");
draw_text(_half_width, _half_height - 6, "PRESS ACTION 2 TO GET A RANDOM SHIELD");
draw_text(_half_width, _half_height + 26, "PRESS START TO LEAVE");