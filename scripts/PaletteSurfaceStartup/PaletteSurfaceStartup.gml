function PaletteSurfaceStartup()
{
	// Create low surface
	if !surface_exists(Palette.SurfaceLow)
	{
		Palette.SurfaceLow = surface_create(Game.ResolutionWidth, Game.ResolutionHeight);
		view_surface_id[0] = Palette.SurfaceLow;
	}
	
	// Create high surface
	if !surface_exists(Palette.SurfaceHigh)
	{
		Palette.SurfaceHigh = surface_create(Game.ResolutionWidth, Game.ResolutionHeight);
	}
}