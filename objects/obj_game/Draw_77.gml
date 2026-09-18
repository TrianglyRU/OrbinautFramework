/// @description Compose Views
if room == rm_startup
{
	return;
}

gpu_set_blendenable(false);
surface_set_target(application_surface);

FOR_EACH_VISIBLE_VIEW
{
	draw_surface_part(view_surface_id[_v], CAMERA_HORIZONTAL_BUFFER, 0, view_get_wport(_v) - CAMERA_HORIZONTAL_BUFFER * 2, view_get_hport(_v), view_get_xport(_v), view_get_yport(_v));
}

surface_reset_target();
gpu_set_blendenable(true);