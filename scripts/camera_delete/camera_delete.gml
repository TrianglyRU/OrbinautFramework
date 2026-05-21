/// @self
/// @description			Deletes the camera and surface for the given viewport index.
/// @param {Real} _index	The viewport index.
function camera_delete(_index)
{
	camera_destroy(view_camera[_index]);
	surface_free(view_surface_id[_index]);
	
	view_visible[_index] = false;
	view_camera[_index] = -1;
	view_data[_index] = undefined;
}