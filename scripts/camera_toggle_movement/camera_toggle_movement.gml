/// @self
/// @description			Enables or disables movement for the camera created by camera_new() at the given index.
/// @param {Real} _index	The viewport index.
/// @param {Bool} _enable	Whether to enable (true) or disable (false) camera movement.
function camera_toggle_movement(_index, _enable)
{
	var _camera_data = view_data[_index];
	
	if _camera_data != undefined
	{
		_camera_data.allow_movement = _enable;
	}
}