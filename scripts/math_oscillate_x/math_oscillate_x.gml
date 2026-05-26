/// @self
/// @description				Oscillates a value using the sine function.
/// @param {Real} _start_val	The base value to oscillate from.
/// @param {Real} _angle		The current angle or time value.
/// @param {Real} _dist			The amplitude of the oscillation.
/// @returns {Real}
function math_oscillate_x(_start_val, _angle, _dist)
{
	return round(_start_val + dsin(_angle % 360) * _dist);
}