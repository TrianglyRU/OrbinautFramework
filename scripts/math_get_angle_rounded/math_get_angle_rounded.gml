/// @self
/// @description Rounds an angle in degrees to the nearest value in the raw angle system.
/// @param {Real} angle The angle in degrees to be rounded.
/// @returns {Real}
function math_get_angle_rounded(_angle)
{
	return round(_angle / ANGLE_INCREMENT) * ANGLE_INCREMENT
}