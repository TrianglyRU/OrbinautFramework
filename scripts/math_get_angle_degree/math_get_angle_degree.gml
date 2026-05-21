/// @self
/// @description		Converts a raw angle to degrees.
/// @param {Real} _raw	The raw angle to convert.
/// @returns {Real}
function math_get_angle_degree(_raw)
{
	return ((ANGLE_RAW_MAX - _raw) * 360 / ANGLE_RAW_MAX) % 360;
}