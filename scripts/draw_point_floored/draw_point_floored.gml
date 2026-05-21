/// @self
/// @description					Draws a point with coordinates rounded down to the nearest integer.
/// @param {Real} _x1				The x-coordinate of the point.
/// @param {Real} _y1				The y-coordinate of the point.
/// @param {Constant.Color} [_col]	The colour of the point (default is c_white).
function draw_point_floored(_x1, _y1, _col = c_white)
{
	draw_point_colour(floor(_x1) + 1, floor(_y1) + 1, _col);
}