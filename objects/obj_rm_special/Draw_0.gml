if state == SPECIAL_STAGE_STATE.RESULTS
{
    return;
}

var _half_width = camera_get_width(0) * 0.5;
var _half_height = camera_get_height(0) * 0.5;
var _title_string = "* SPECIAL STAGE *";
var _length = string_length(_title_string);

draw_set_font(global.font_data[? spr_font_small]);
draw_set_halign(fa_center);

for (var _i = 0; _i < _length; _i++)
{
    var _offset_x = (_i - round(_length * 0.5)) * 8;
    var _offset_y = math_oscillate_y(0, obj_game.frame_counter * 4, 2, 1, _i * 48);
	
    draw_text(_half_width + _offset_x, 48 + _offset_y, string_char_at(_title_string, _i + 1));
}

if state >= SPECIAL_STAGE_STATE.EMERALD
{
    if obj_game.frame_counter % 20 < 10
    {
		var _text = state == SPECIAL_STAGE_STATE.EMERALD ? "YOU GOT A CHAOS EMERALD!"
													     : "YOU GOT ALL CHAOS EMERALDS!";												   
        draw_text(_half_width, _half_height + 84, _text);
    }  
}
else
{
	draw_text(_half_width, _half_height + 64, "PRESS ACTION 1 TO GET A CHAOS EMERALD");
	draw_text(_half_width, _half_height + 74, "PRESS START TO LEAVE");
}