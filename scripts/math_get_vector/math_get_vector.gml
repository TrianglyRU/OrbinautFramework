/// @self
/// @description			Calculates the angle of a vector in degrees.
/// @param {Real} _x_dist	The x-component of the vector.
/// @param {Real} _y_dist	The y-component of the vector.
/// @returns {Real}
function math_get_vector(_x_dist, _y_dist)
{
	return (point_direction(0, 0, _x_dist, _y_dist) + 90) % 360;
}