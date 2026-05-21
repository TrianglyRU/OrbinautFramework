/// @description Gamepad Detection
var _connected_index = async_get("gamepad discovered", "pad_index");
var _lost_index = async_get("gamepad lost", "pad_index");

if _connected_index != undefined
{
	ds_list_add(global.gamepads, _connected_index);
	gamepad_set_axis_deadzone(_connected_index, INPUT_GAMEPAD_DEADZONE);
	
	show_debug_message($"[INFO] {gamepad_get_description(_connected_index)} ({_connected_index}) has been registered into slot {ds_list_size(global.gamepads)}");
}

if _lost_index != undefined
{
	if ds_list_delete_value(global.gamepads, _lost_index)
	{
		show_debug_message($"[INFO] Gamepad {_lost_index} has been removed");
	}
}