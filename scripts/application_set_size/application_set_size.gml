/// @function application_set_size(width,height)
function application_set_size(width,height)
{	
	// Set camera and surface size
	camera_set_view_size(GameCamera, width, height);
	surface_resize(application_surface, width, height);

	// Resize palette surfaces
	if surface_exists(Palette.SurfaceLow)
	{
		surface_resize(Palette.SurfaceLow, width, height);
	}
	if surface_exists(Palette.SurfaceHigh)
	{
		surface_resize(Palette.SurfaceHigh, width, height);
	}
	
	// Update room size
	if room_width < Game.Width
	{
		room_width = Game.Width;
	}
	if room_height < Game.Height
	{
		room_height = Game.Height;
	}

	// Re-enable surface rendering
	application_surface_draw_enable(true);
}