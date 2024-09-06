/// @self
/// @description Calculates a degree angle of a vector rounded to the nearest value in the raw angle system.
/// @param {Real} x_dist The x-component of the vector.
/// @param {Real} y_dist The y-component of the vector.
/// @returns {Real}
function math_get_vector_rounded(_x_dist, _y_dist)
{
	return math_get_angle_rounded(math_get_vector(_x_dist, _y_dist));
}