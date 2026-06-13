/// @self
/// @description			Returns the height of the camera culling region used for instance activation and deactivation.
/// @param {Real} _index	The viewport index.
/// @returns {Real}
function camera_get_culling_height(_index)
{
	return camera_get_height(_index) + CULLING_ADD_HEIGHT + CULLING_ROUND_VALUE;
}