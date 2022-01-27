/// @function application_set_size(width,height)
function application_set_size(width,height)
{	
	// Update window size
	window_set_size(width * Game.WindowSize, height * Game.WindowSize);

	// Update surfaces
	if surface_exists(Palette.SurfaceLow)
	{
		surface_free(Palette.SurfaceLow);
	}
	if surface_exists(Palette.SurfaceHigh)
	{
		surface_free(Palette.SurfaceHigh);
	}
	surface_resize(application_surface, width, height);
	
	// Update room and camera view size
	if !instance_exists(Stage)
	{
		room_width  = Game.Width;
		room_height = Game.Height;
	}
	camera_set_view_size(GameCamera, width, height);
}