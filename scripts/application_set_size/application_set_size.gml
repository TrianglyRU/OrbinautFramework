/// @function application_set_size(appWidth, appHeight)
function application_set_size(appWidth, appHeight)
{	
	// Set camera size
	camera_set_view_size(view_camera[0], appWidth, appHeight);
	
	// Set application surface/viewport size
	surface_resize(application_surface,  appWidth, appHeight);
	
	// Resize main and background surfaces
	if instance_exists(Screen)
	{
		if surface_exists(Screen.AppSurface)
		{
			surface_resize(Screen.AppSurface, appWidth, appHeight);
		}
	}
	
	// Enable surface rendering in case it was disabled
	application_surface_draw_enable(true);
}