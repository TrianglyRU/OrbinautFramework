/// @self
/// @description			Edits the specified view's camera and viewport settings. This will automatically make the view visible.
/// @param {Real} _index	The index of the view to modify.
/// @param {Real} _w		The new horizontal resolution of the camera.
/// @param {Real} _h		The new vertical resolution of the camera.
/// @param {Real} _wport	The new horizontal size of the viewport.
/// @param {Real} _hport	The new vertical size of the viewport.
/// @param {Real} _xport	The new horizontal position of the viewport on the screen.
/// @param {Real} _yport	The new vertical position of the viewport on the screen.
function view_edit(_index, _w, _h, _wport, _hport, _xport, _yport)
{
	view_set_wport(_index, _wport + CAMERA_HORIZONTAL_BUFFER * 2);
	view_set_hport(_index, _hport);
	view_set_xport(_index, _xport)
	view_set_yport(_index, _yport);
	
	camera_set_view_size(view_camera[_index], _w + CAMERA_HORIZONTAL_BUFFER * 2, _h);
	surface_free(view_surface_id[_index]);
	
	view_visible[_index] = true;
}