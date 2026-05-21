enum QUADRANT
{
	DOWN = 0, RIGHT = 1, UP = 2, LEFT = 3
}

/// @self
/// @description			Converts an angle in degrees to its corresponding quadrant (0 to 3).
/// @param {Real} _angle	The angle in degrees.
/// @returns {Enum.QUADRANT}
function math_get_quadrant(_angle)
{
	if _angle > 45 && _angle < 135
	{
		return QUADRANT.RIGHT;
	}
	
	if _angle >= 135 && _angle <= 225
	{
		return QUADRANT.UP;
	}
	
	if _angle > 225 && _angle < 315
	{
		return QUADRANT.LEFT;
	}
	
	return QUADRANT.DOWN;
}