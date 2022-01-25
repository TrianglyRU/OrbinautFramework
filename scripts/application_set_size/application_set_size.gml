/// @function application_set_size(width,height)
function application_set_size(width,height)
{	
	// Set camera and surface size
	window_set_size(width * Game.WindowSize, height * Game.WindowSize);
	camera_set_view_size(GameCamera, width, height);

	// Clear palette surfaces. They will be created automatically once again
	if surface_exists(Palette.SurfaceLow)
	{
		surface_free(Palette.SurfaceLow);
	}
	if surface_exists(Palette.SurfaceHigh)
	{
		surface_free(Palette.SurfaceHigh);
	}
	
	// Resize main surface
	surface_resize(application_surface, width, height);
	
	// Update room size
	if !instance_exists(Stage)
	{
		room_width  = Game.Width;
		room_height = Game.Height;
	}
}