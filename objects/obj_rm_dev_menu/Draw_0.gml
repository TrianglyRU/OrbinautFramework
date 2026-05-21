var _w = camera_get_width(0);
var _h = camera_get_height(0);
var _dx = _w * 0.5;
var _dy = _h * 0.5 - 16;
var _options_per_page = 7;
var _current_page_index = floor(option_id / _options_per_page);
var _total_pages = ceil(category_options_count / _options_per_page);
var _first_option_id = _current_page_index * _options_per_page;
var _last_option_id = min(category_options_count, _current_page_index * _options_per_page + _options_per_page);
var _title = category_data[DEVM_CATEGORY_TITLE];

draw_set_font(global.font_data[? spr_font_system]);
draw_set_halign(fa_center);

for (var _i = _first_option_id; _i < _last_option_id; _i++)
{
    var _option_y = _dy + (_i % _options_per_page) * 8;
    var _string = category_data[_i + DEVM_CATEGORY_SYSTEM_DATA];
	
	if _i == option_id
	{
		draw_set_colour(c_white);
	}
	else
	{
		draw_set_colour(#6D6D6D);
	}
	
    draw_text(_dx, _option_y, _string);
}

if _total_pages > 1
{
	draw_set_colour(#6D6D6D);
	draw_text(_dx, _dy - 16, "(" + string(_current_page_index + 1) + "/" + string(_total_pages) + ")");
}

if category_id == 4 || category_id == 5
{
	_title += "\nsave slot: " + string(global.current_save_slot);
}

draw_set_colour(c_white);
draw_text(_dx, _dy - 48, _title);