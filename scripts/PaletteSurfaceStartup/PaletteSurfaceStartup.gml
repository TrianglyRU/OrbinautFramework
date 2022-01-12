function PaletteSurfaceStartup()
{
	// Create surfaces
	if !surface_exists(SurfaceLow)
	{
		SurfaceLow = surface_create(Game.Width, Game.Height); view_surface_id[0] = SurfaceLow;
	}
	if !surface_exists(SurfaceHigh)
	{
		SurfaceHigh = surface_create(Game.Width, Game.Height);
	}
}