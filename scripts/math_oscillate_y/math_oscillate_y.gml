/// @self
/// @description				Oscillates a value using the cosine function.
/// @param {Real} _start_val	The base value to oscillate from.
/// @param {Real} _angle		The current angle or time value.
/// @param {Real} _dist			The amplitude (radius) of the oscillation.
/// @returns {Real}
function math_oscillate_y(_start_val, _angle, _dist)
{
	return round(_start_val + dcos(_angle % 360) * _dist);
}