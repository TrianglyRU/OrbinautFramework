function PaletteSurfaceStartup()
{
	// Create low surface
	if !surface_exists(SurfaceLow)
	{
		SurfaceLow = surface_create(Game.ResolutionWidth, Game.ResolutionHeight);
		view_surface_id[0] = SurfaceLow;
	}
	
	// Create high surface
	if !surface_exists(SurfaceHigh)
	{
		SurfaceHigh = surface_create(Game.ResolutionWidth, Game.ResolutionHeight);
	}
}