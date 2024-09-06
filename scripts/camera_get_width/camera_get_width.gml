/// @self
/// @description Returns the horizontal resolution of the camera associated with the specified viewport index.
/// @param {Real} index The index of the viewport.
/// @returns {Real}
function camera_get_width(_index)
{
	return camera_get_view_width(view_camera[_index]) - ENGINE_RENDERER_HORIZONTAL_BUFFER * 2;
}
