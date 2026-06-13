/// @self
/// @description			Returns the corrected height of the camera.
/// @param {Real} _index	The viewport index.
/// @returns {Real}
function camera_get_height(_index)
{
	return camera_get_view_height(view_camera[_index]);
}