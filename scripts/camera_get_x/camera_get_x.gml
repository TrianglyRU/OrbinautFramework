/// @self
/// @description Returns the adjusted x position of the camera associated with the specified viewport index.
/// @param {Real} index The index of the viewport.
/// @returns {Real}
function camera_get_x(_index)
{
	return camera_get_view_x(view_camera[_index]) + ENGINE_RENDERER_HORIZONTAL_BUFFER;
}
