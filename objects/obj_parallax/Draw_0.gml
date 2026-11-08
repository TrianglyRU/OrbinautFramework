var _c = view_camera[view_current];

if _c == -1 || !draw_enabled[view_current]
{
    return;
}

var _cx = camera_get_x(view_current);
var _cy = camera_get_y(view_current);
var _cw = camera_get_width(view_current);
var _ch = camera_get_height(view_current);

var _camera_limit_left  = _cx - CAMERA_HORIZONTAL_BUFFER;
var _camera_limit_right = _cx + _cw + CAMERA_HORIZONTAL_BUFFER;

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

var _shader = shader_current();
var _use_line_scroll = line_height > 0;

if _use_line_scroll
{
	// Create a surface matching the raw camera view size
	if !surface_exists(surface)
	{
		surface = surface_create(camera_get_view_width(_c), camera_get_view_height(_c));
	}
	
	surface_set_target(surface);
	draw_clear_alpha(c_white, 0);
	
	// Views the same room area as the camera (draw in room coordinates)
	camera_apply(_c);
	
	shader_reset();
	shader_line_scroll(_cx, _draw_x, _draw_y, height, _scale_y, texture, line_factor_x - factor_x, line_height);
}

if vtiled
{
    draw_sprite_tiled_ext(sprite_index, image_index, _draw_x, _draw_y, image_xscale, _scale_y, draw_colour, image_alpha);
}
else if htiled
{
    draw_sprite_tiled_h_ext(sprite_index, image_index, 0, 0, width, height, _draw_x, _draw_y, image_xscale, _scale_y, draw_colour, image_alpha, _camera_limit_left, _camera_limit_right);
}
else
{
    draw_sprite_ext(sprite_index, image_index, _draw_x, _draw_y, image_xscale, _scale_y, image_angle, draw_colour, image_alpha);
}

if _use_line_scroll
{
	shader_reset();
	surface_reset_target();
	
	if _shader != -1
	{
		shader_set(_shader);
	}
	
	// Draw the surface at the camera's raw position
	draw_surface(surface, camera_get_view_x(_c), camera_get_view_y(_c));
}