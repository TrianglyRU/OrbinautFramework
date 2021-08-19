/// @function application_set_size(appWidth, appHeight)
function application_set_size(appWidth, appHeight)
{	
	// Set camera size and resize application surface
	camera_set_view_size(GameCamera, appWidth, appHeight);
	surface_resize(application_surface, appWidth, appHeight);

	// Resize palette surfaces
	if surface_exists(Palette.SurfaceLow)
	{
		surface_resize(Palette.SurfaceLow, appWidth, appHeight);
	}
	if surface_exists(Palette.SurfaceHigh)
	{
		surface_resize(Palette.SurfaceHigh, appWidth, appHeight);
	}

	// Re-enable surface rendering
	application_surface_draw_enable(true);
}