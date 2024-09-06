var _x = camera_get_x(view_current);
var _y = camera_get_y(view_current);
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);
	
draw_rect_floored(_x, c_framework.palette.split_bound, _x + _w, _y + _h, false);