/// @self
/// @description					Draws a rectangle with coordinates rounded down to the nearest integer.
/// @param {Real} _x1				The x-coordinate of the top-left corner.
/// @param {Real} _y1				The y-coordinate of the top-left corner.
/// @param {Real} _x2				The x-coordinate of the bottom-right corner.
/// @param {Real} _y2				The y-coordinate of the bottom-right corner.
/// @param {Bool} _is_outlined		Specifies whether the rectangle should be outlined (true) or filled (false).
/// @param {Constant.Color} [_col]	The colour of the rectangle (default is c_white).
function draw_rect_floored(_x1, _y1, _x2, _y2, _is_outlined, _col = c_white)
{
	draw_rectangle_colour(floor(_x1) + _is_outlined, floor(_y1) + _is_outlined, floor(_x2), floor(_y2), _col, _col, _col, _col, _is_outlined);
}