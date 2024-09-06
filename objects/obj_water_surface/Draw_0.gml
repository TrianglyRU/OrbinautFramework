// Override draw
	
var _water_level = c_stage.water_level;
var _ss_position = _water_level - camera_get_y(view_current);

// Exit if the sprite is outside the camera view
if _ss_position < -sprite_height || _ss_position > camera_get_height(view_current) + sprite_height
{
	exit;
}

var _draw_count = ceil(camera_get_width(view_current) / sprite_width);
var _raw_x = floor(camera_get_x(view_current) / sprite_width);

// Draw sprites across the screen
for (var i = 0; i <= _draw_count; i++)
{
	var _x = (_raw_x + i) * sprite_width + sprite_width / 2;
	var _y = _water_level;
	draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, 0, c_white, 0.5);
}