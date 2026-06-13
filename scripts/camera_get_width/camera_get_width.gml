/// @self
/// @description			Returns the corrected width of the camera.
/// @param {Real} _index	The viewport index.
/// @returns {Real}
function camera_get_width(_index)
{
    return camera_get_view_width(view_camera[_index]) - CAMERA_HORIZONTAL_BUFFER * 2;
}