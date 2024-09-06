/// @self
/// @description Returns the camera associated with the specified viewport index.
/// @param {Real} index The index of viewport.
/// @returns {Id.Camera}
function camera_get(_index)
{
	return view_camera[_index];
}
