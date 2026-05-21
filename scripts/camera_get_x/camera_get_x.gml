/// @self
/// @description			A wrapper around camera_get_view_x().
/// @param {Real} _index	The viewport index.
/// @returns {Real}
function camera_get_x(_index)
{
    return camera_get_view_x(view_camera[_index]) + CAMERA_HORIZONTAL_BUFFER;
}