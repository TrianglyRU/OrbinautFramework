/// @self
/// @description Converts a raw angle to its equivalent angle in degrees.
/// @param {Real} raw The raw angle to convert.
/// @returns {Real}
function math_get_angle_degree(_raw)
{
	return ((ENGINE_ANGLE_MAX_RAW - _raw) * ENGINE_ANGLE_MAX_DEC / ENGINE_ANGLE_MAX_RAW) % ENGINE_ANGLE_MAX_DEC;
}