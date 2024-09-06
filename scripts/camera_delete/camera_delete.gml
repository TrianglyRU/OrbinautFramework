/// @self
/// @description Deletes the camera and the surface associated with the specified viewport index.
/// @param {Real} index The index of the viewport.
function camera_delete(_index)
{
	delete c_framework.camera_data[_index];
	
	if surface_exists(view_surface_id[_index])
	{
		surface_free(view_surface_id[_index]);
	}
	
	c_framework.camera_data[_index] = noone;
	view_visible[_index] = false;
}