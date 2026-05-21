/// @self
/// @description					Draws a line with coordinates rounded down to the nearest integer.
/// @param {Real} _x1				The x-coordinate of the line's starting point.
/// @param {Real} _y1				The y-coordinate of the line's starting point.
/// @param {Real} _x2				The x-coordinate of the line's ending point.
/// @param {Real} _y2				The y-coordinate of the line's ending point.
/// @param {Constant.Color} [_col1]	The colour of the line at the starting point (default is c_white).
/// @param {Constant.Color} [_col2] The colour of the line at the ending point (default is col1).
function draw_line_floored(_x1, _y1, _x2, _y2, _col1 = c_white, _col2 = _col1)
{
	draw_line_colour(floor(_x1), floor(_y1), floor(_x2), floor(_y2), _col1, _col2);
}