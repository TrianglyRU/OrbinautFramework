/// @self
/// @description Returns the vertical resolution of the camera associated with the specified viewport index.
/// @param {Real} index The index of the viewport.
/// @returns {Real}
function camera_get_height(_index)
{
	return camera_get_view_height(view_camera[_index]);
}
