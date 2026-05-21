/// @self
/// @description			Returns the corrected width of the camera created by camera_new() function.
/// @param {Real} _index	The camera index.
/// @returns {Real}
function camera_get_width(_index)
{
    return camera_get_view_width(view_camera[_index]) - CAMERA_HORIZONTAL_BUFFER * 2;
}