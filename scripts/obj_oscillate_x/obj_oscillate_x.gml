/// @self c_object
/// @description Oscillates an object's x position based on the specified parameters.
/// @param {Real} start_x The initial x position for the oscillation.
/// @param {Real} angle The angle or timer value used for the oscillation.
/// @param {Real} dist The amplitude of the oscillation, determining how far the object moves from its starting position.
/// @param {Real} [spd] The speed at which the oscillation occurs (optional, defaults to 1).
/// @param {Real} [offset] A value that shifts the angle of the oscillation (optional, defaults to 0).
/// @returns {Real}
function obj_oscillate_x(_start_x, _angle, _dist, _spd = 1, _offset = 0)
{
	return round(_start_x + dsin((_angle * _spd + _offset) % 360) * _dist);
}