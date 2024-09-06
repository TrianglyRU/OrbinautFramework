/// @self
/// @description Converts an angle in degrees to its corresponding quadrant from 0 to 3.
/// @param {Real} angle The angle in degrees.
/// @returns {Real}
function math_get_quadrant(_angle)
{
    /*
	If the angle is greater than 315 or  less than or equal to 45,  it returns QUADRANT.DOWN (0)
    If the angle is greater than 45  and less than or equal to 135, it returns QUADRANT.RIGHT (1)
    If the angle is greater than 135 and less than or equal to 225, it returns QUADRANT.UP (2)
    If the angle is greater than 225 and less than or equal to 315, it returns QUADRANT.LEFT (3) 
	*/
	return floor(floor(_angle % 360 + 45 - ANGLE_INCREMENT) / 90) % 4;
}