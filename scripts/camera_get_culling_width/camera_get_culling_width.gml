/// @self
/// @description			Returns the width of the camera culling region used for instance activation and deactivation.
/// @param {Real} _index	The viewport index.
/// @returns {Real}
function camera_get_culling_width(_index)
{
	return camera_get_width(_index) + CULLING_ADD_WIDTH + CULLING_ROUND_VALUE;
}