/// @self
/// @description				Returns the width of the camera culling region used for instance activation and deactivation.
/// @param {Real} _camera_index	The camera index.
/// @returns {Real}
function camera_get_culling_width(_camera_index)
{
	return camera_get_width(_camera_index) + CULLING_ADD_WIDTH + CULLING_ROUND_VALUE;
}