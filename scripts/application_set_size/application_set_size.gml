/// @function application_set_size(width,height)
function application_set_size(width,height)
{	
	// Free surfaces, they'll be re-created in the Pre-Draw Event of Renderer contoller
	if instance_exists(Renderer)
	{
		if surface_exists(Renderer.SurfaceLow)
		{
			surface_free(Renderer.SurfaceLow);
		}
		if surface_exists(Renderer.SurfaceHigh)
		{
			surface_free(Renderer.SurfaceHigh);
		}
	}
	surface_resize(application_surface, width, height);
	
	// Update camera and its viewport size
	view_enabled[0] = true;
	view_visible[0] = true;
	
	camera_set_view_size(GameCamera, width + global.ScreenBuffer * 2, height);
}