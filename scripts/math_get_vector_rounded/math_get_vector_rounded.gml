/// @self
/// @description			Calculates the angle of a vector and rounds it to the nearest angle from the 256-step raw system, expressed in degrees.
/// @param {Real} _x_dist	The x-component of the vector.
/// @param {Real} _y_dist	The y-component of the vector.
/// @returns {Real}
function math_get_vector_rounded(_x_dist, _y_dist)
{
	return math_get_angle_rounded(math_get_vector(_x_dist, _y_dist));
}