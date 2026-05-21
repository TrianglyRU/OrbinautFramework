/// @self
/// @description				Sets a rumble effect for the specified input slot.
/// @param {Real} _slot_id		The ID of the input slot.
/// @param {Real} _time			The duration of the rumble effect in seconds.
/// @param {Real} _left_motor	The intensity of the left motor rumble (0 to 1).
/// @param {Real} _right_motor	The intensity of the right motor rumble (0 to 1, default is _left_motor).
function input_set_rumble(_slot_id, _time, _left_motor, _right_motor = _left_motor)
{
	if !global.gamepad_rumble || _slot_id >= INPUT_SLOT_COUNT
	{
		return;
	}
	
	var _pad_index = input_get_gamepad_index(_slot_id);
	
	if _pad_index != undefined
	{
		gamepad_set_vibration(_pad_index, clamp(_left_motor, 0, 1), clamp(_right_motor, 0, 1));
	}
	
	obj_game.input_rumble_time_left[_slot_id] = _time * game_get_speed(gamespeed_fps);
}