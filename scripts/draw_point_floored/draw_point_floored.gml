/// @self
/// @description Draws a point with coordinates rounded down to the nearest integer.
/// @param {Real} x1 The x-coordinate of the point.
/// @param {Real} y1 The y-coordinate of the point.
/// @param {Constant.Color} [col] The colour of the point (optional, defaults to c_white).
function draw_point_floored(_x1, _y1, _col = c_white)
{
	draw_point_colour(floor(_x1), floor(_y1), _col);
}