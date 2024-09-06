/// @self
/// @description Converts an angle in degrees to its equivalent raw angle.
/// @param {Real} angle The angle in degrees to convert.
/// @returns {Real}
function math_get_angle_raw(_angle)
{
	return round((ENGINE_ANGLE_MAX_DEC - _angle) / ENGINE_ANGLE_MAX_DEC * ENGINE_ANGLE_MAX_RAW);
}