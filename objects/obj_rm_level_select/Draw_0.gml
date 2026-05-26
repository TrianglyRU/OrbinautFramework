var _w = camera_get_width(0);
var _h = camera_get_height(0);
var _x = _w * 0.5 - 136;
var _start_y = _h * 0.5 - 103 + 16;
var _y = _start_y;

var _sound_index = global.selected_sound_index;

var _total_entries = array_length(level_entries);
var _selected_entry_index = global.selected_level_entry;
var _prev_empty_index = _selected_entry_index;

do
{
	_prev_empty_index--
}
until _prev_empty_index == -1 || !is_string_entry(_prev_empty_index)

draw_set_halign(fa_left);
draw_set_font(global.font_data[? spr_font_small]);

for (var _i = 0; _i < _total_entries; _i++)
{
	var _entry_text = get_entry_text_array(_i);
	var _main = _entry_text[0];
	
	if _main == "/n"
	{
	    _x += 152;
	    _y = _start_y;
		
		// Do not add 8 to _y
	    continue;
	}
	else if _main == "/p" && global.current_save_slot == undefined
	{
	    draw_set_colour(level_entries[_selected_entry_index] != "SOUND TEST" ? c_yellow : c_white);
	    draw_text(_x + 88, _y, dec_to_hex(global.selected_player_index));
		draw_set_colour(c_white);
	}
	else if _main != ""
	{
		// Draw main
		draw_set_colour(_i > _prev_empty_index && _i <= _selected_entry_index ? c_yellow : c_white);
		
		if _main == "SOUND TEST"
		{
		    draw_text(_x, _y, _main + "  *" + dec_to_hex(_sound_index) + "*");
		}
		else
		{
		    draw_text(_x, _y, _main);
		}
		
		draw_set_colour(c_white);
		
		// Draw act number
	    if array_length(_entry_text) > 1
	    {
			if _i == _selected_entry_index
			{
				draw_set_colour(c_yellow);
			}
			
	        draw_text(_x + 120, _y, _entry_text[1]);
			draw_set_colour(c_white);
	    }
	}
	
    _y += 8;
}