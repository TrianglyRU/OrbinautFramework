if view_camera[view_current] == -1 || !draw_enabled[view_current]
{
    return;
}

var _cx = camera_get_x(view_current);
var _cy = camera_get_y(view_current);
var _cw = camera_get_width(view_current);

var _draw_x = get_draw_x(_cx, factor_x) + draw_offset_x;
var _draw_y = get_draw_y(_cy, factor_y) + draw_offset_y;

var _scale_y;

if scale_target_y != -1
{
    _scale_y = clamp((scale_target_y - _draw_y) / height, -1, 1);
}
else
{
    _scale_y = 1;
}

var _camera_limit_left  = _cx - CAMERA_HORIZONTAL_BUFFER;
var _camera_limit_right = _cx + _cw + CAMERA_HORIZONTAL_BUFFER;

if vtiled
{
    draw_sprite_tiled_ext(sprite_index, image_index, _draw_x, _draw_y, image_xscale, _scale_y, draw_colour, image_alpha);
}
else if htiled
{
    if line_height < 0
    {
        draw_sprite_tiled_h_ext(sprite_index, image_index, 0, 0, width, height, _draw_x, _draw_y, image_xscale, _scale_y, draw_colour, image_alpha, _camera_limit_left, _camera_limit_right);
    }
    else
    {
        var _lines_total = height / line_height;
        var _increment = (line_factor_x - factor_x) / _lines_total;
		
        var _scaled_line_h = line_height * abs(_scale_y);
		var _flip = sign(_scale_y);
		
		// This is expensive. Like, really.
        for (var _i = 0; _i < _lines_total; _i++)
        {
			var _j = _flip > 0 ? _i : _lines_total - 1 - _i;
			
			var _src_y = _j * line_height;
			var _line_height = min(line_height, tex_height - _src_y);
			
			if _line_height <= 0
			{
				break;
			}
			
			var _relative_offset_factor = _j / (_lines_total - 1);
            var _line_x = get_draw_x(_cx, factor_x + _j * _increment) + floor(draw_offset_x * _relative_offset_factor);
			var _line_y;
			
            if _flip > 0
            {
                _line_y = _draw_y + _i * _scaled_line_h;
            }
            else
            {
                _line_y = _draw_y - (_lines_total - 1 - _i) * _scaled_line_h;
            }
			
			draw_sprite_tiled_h_ext(sprite_index, image_index, 0, _src_y, width, _line_height, _line_x, _line_y, image_xscale, _flip * abs(_scale_y), draw_colour, image_alpha, _camera_limit_left, _camera_limit_right);
		}
    }
}
else
{
    draw_sprite_ext(sprite_index, image_index, _draw_x, _draw_y, image_xscale, _scale_y, image_angle, draw_colour, image_alpha);
}