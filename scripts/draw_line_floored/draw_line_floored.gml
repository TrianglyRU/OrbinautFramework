/// @self
/// @description Draws a line with coordinates rounded down to the nearest integer.
/// @param {Real} x1 The x-coordinate of the line's starting point.
/// @param {Real} y1 The y-coordinate of the line's starting point.
/// @param {Real} x2 The x-coordinate of the line's ending point.
/// @param {Real} y2 The y-coordinate of the line's ending point.
/// @param {Constant.Color} [col1] The colour of the line at the starting point. (optional, defaults to c_white)
/// @param {Constant.Color} [col2] The colour of the line at the ending point. (optional, defaults to col1)
function draw_line_floored(_x1, _y1, _x2, _y2, _col1 = c_white, _col2 = _col1)
{
	draw_line_colour
	(
		floor(_x1) - (_x1 < _x2), floor(_y1) - (_y1 < _y2), floor(_x2), floor(_y2), _col1, _col2
	);
}