/// @self
/// @description			Converts an angle in degrees to a raw angle.
/// @param {Real} _angle	The angle in degrees to convert.
/// @returns {Real}
function math_get_angle_raw(_angle)
{
	return round((360 - _angle) / 360 * ANGLE_RAW_MAX);
}