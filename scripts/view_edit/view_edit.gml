/// @self
/// @description					Edits the specified view and its render settings.
/// @param {Real} _index			The index of the view to modify.
/// @param {Real} _w				The new horizontal resolution of the camera.
/// @param {Real} _h				The new vertical resolution of the camera.
/// @param {Real} _surface_width	The new horizontal size of the surface.
/// @param {Real} _surface_height	The new vertical size of the surface.
/// @param {Real} _surface_x		The new horizontal position of the surface on the screen.
/// @param {Real} _surface_y		The new vertical position of the surface on the screen.
function view_edit(_index, _w, _h, _surface_width, _surface_height, _surface_x, _surface_y)
{
	var _view_data = view_data[_index];
	
	_view_data.surface_w = _surface_width + CAMERA_HORIZONTAL_BUFFER * 2;
	_view_data.surface_h = _surface_height;
	_view_data.surface_x = _surface_x;
	_view_data.surface_y = _surface_y;
	
	camera_set_view_size(view_camera[_index], _w + CAMERA_HORIZONTAL_BUFFER * 2, _h);
	surface_free(view_surface_id[_index]);
}