// Override draw
	
var _draw_x = x;
var _draw_y = y;
	
if IsScreenSpace
{
	_draw_x = camera_get_x(view_current) + camera_get_width(view_current) / 2 + 112;
	_draw_y = camera_get_y(view_current) + camera_get_height(view_current) / 2 + 52;
}
	
draw_sprite(sprite_index, image_index, _draw_x, _draw_y);