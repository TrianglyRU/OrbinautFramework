/// @self
/// @description			Returns the height of the camera created by camera_new() function.
/// @param {Real} _index	The camera index.
/// @returns {Real}
function camera_get_height(_index)
{
	return camera_get_view_height(view_camera[_index]);
}