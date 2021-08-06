/// @function application_set_size(appWidth, appHeight)
function application_set_size(appWidth, appHeight)
{	
	// Set camera size
	camera_set_view_size(view_camera[0], appWidth, appHeight);
	
	// Set application surface/viewport size
	surface_resize(application_surface, appWidth, appHeight);
	
	// Update palette surfaces
	if instance_exists(Palette)
	{
		if surface_exists(Palette.SurfaceLow)
		{
			surface_resize(Palette.SurfaceLow, appWidth, appHeight);
		}
		if surface_exists(Palette.SurfaceHigh)
		{
			surface_resize(Palette.SurfaceHigh, appWidth, appHeight);
		}
	}
	
	// Enable surface rendering in case it was disabled
	application_surface_draw_enable(true);
}