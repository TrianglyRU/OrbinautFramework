/// @description Compose Views
if room == rm_startup
{
	return;
}

gpu_set_blendenable(false);
surface_set_target(application_surface);

FOR_EACH_CAMERA
{
	var _camera_data = view_data[_c];
	var _surface = view_surface_id[_c];
	
	if _camera_data != undefined
	{
		draw_surface_part(_surface, CAMERA_HORIZONTAL_BUFFER, 0, surface_get_width(_surface) - CAMERA_HORIZONTAL_BUFFER * 2, surface_get_height(_surface), _camera_data.surface_x, _camera_data.surface_y);
	}
}

surface_reset_target();
gpu_set_blendenable(true);