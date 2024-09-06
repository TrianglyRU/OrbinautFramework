/// @self
/// @description Sets a rumble effect on the specified gamepad slot.
/// @param {Real} input_id The ID of the gamepad slot to apply the rumble effect to.
/// @param {Real} time The duration of the rumble effect in seconds.
/// @param {Real} left_motor The intensity of the rumble effect for the left motor, ranging from 0 to 1.
/// @param {Real} right_motor The intensity of the rumble effect for the right motor, ranging from 0 to 1.
function input_set_rumble(_input_id, _time, _left_motor, _right_motor)
{
	// Exit if rumble is disabled or input_id is invalid
	var _input = c_framework.input;
	var _pads_array = _input.pads_array;
	
	if !global.gamepad_rumble || _input_id >= ENGINE_INPUT_MAX_DEVICE_COUNT || _input_id >= array_length(_pads_array)
	{
		exit;
	}

	// Set vibration parameters
	_input.vibration[_input_id] = _time * ENGINE_TARGET_FPS;

	_left_motor = clamp(_left_motor, 0, 1);
	_right_motor = clamp(_right_motor, 0, 1);

	// Apply vibration settings
	gamepad_set_vibration(_pads_array[_input_id], _left_motor / 8, _right_motor / 8);
}