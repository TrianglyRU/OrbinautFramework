/// @self
/// @description				Returns the height of the camera culling region used for instance activation and deactivation.
/// @param {Real} _camera_index	The camera index.
/// @returns {Real}
function camera_get_culling_height(_camera_index)
{
	return camera_get_height(_camera_index) + CULLING_ADD_HEIGHT + CULLING_ROUND_VALUE;
}