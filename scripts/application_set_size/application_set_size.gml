/// @function application_set_size(width,height)
function application_set_size(width,height)
{	
	// Update window size
	window_set_size(width * global.WindowSize, height * global.WindowSize);

	// Update surfaces
	if surface_exists(Renderer.SurfaceLow)
	{
		surface_free(Renderer.SurfaceLow);
	}
	if surface_exists(Renderer.SurfaceHigh)
	{
		surface_free(Renderer.SurfaceHigh);
	}
	surface_resize(application_surface, width, height);
	
	// Update room and camera view size
	if !instance_exists(Stage)
	{
		room_width  = global.Width;
		room_height = global.Height;
	}
	camera_set_view_size(GameCamera, width, height);
}