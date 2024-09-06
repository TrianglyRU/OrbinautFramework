var OPTIONS_PER_PAGE = 7;

var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);
var _draw_x = _width / 2;
var _draw_y = _height / 2;

draw_set_font(global.font_system);
draw_set_halign(fa_center);

draw_text(_draw_x, _draw_y - 62, category_data[2]);

// Determine current page and last option on the page
var _current_page = floor(option_id / OPTIONS_PER_PAGE);
var _last_option_id = min(category_options_count, _current_page * OPTIONS_PER_PAGE + OPTIONS_PER_PAGE);

// Draw each option on the current page
for (var i = _current_page * OPTIONS_PER_PAGE; i < _last_option_id; i++)
{
    var _option_y = _draw_y - 12 + (i % OPTIONS_PER_PAGE) * 10;
    var _string = category_data[3 + i];
    
    draw_text(_draw_x, _option_y, _string);
    
    if i != option_id
    {
        continue;
    }
    
    var _length = string_length(_string) * 8;
    
    draw_text((_width - _length) / 2 - 8, _option_y, ">");
    draw_text((_width + _length) / 2 + 8, _option_y, "<");
}