/// @self
/// @description				Oscillates a value using the cosine function.
/// @param {Real} _start_val	The base value to oscillate from.
/// @param {Real} _angle		The current angle or time value.
/// @param {Real} _dist			The amplitude (radius) of the oscillation.
/// @param {Real} [_spd]		The oscillation speed (default is 1).
/// @param {Real} [_offset]		An additional angle offset (default is 0).
/// @returns {Real}
function math_oscillate_y(_start_val, _angle, _dist, _spd = 1, _offset = 0)
{
	return round(_start_val + dcos((_angle * _spd + _offset) % 360) * _dist);
}