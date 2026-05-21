/// @self
/// @description			Rounds an angle to the nearest angle from the 256-step raw system, expressed in degrees.
/// @param {Real} _angle	The angle in degrees to round.
/// @returns {Real}
function math_get_angle_rounded(_angle)
{
	return round(_angle / ANGLE_INCREMENT) * ANGLE_INCREMENT;
}