/// @self
/// @description Returns the y position of the camera associated with the specified viewport index.
/// @param {Real} index The index of the viewport.
/// @returns {Real}
function camera_get_y(_index)
{
	return camera_get_view_y(view_camera[_index]);
}
