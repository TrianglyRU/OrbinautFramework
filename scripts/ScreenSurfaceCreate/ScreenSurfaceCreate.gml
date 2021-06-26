function ScreenSurfaceCreate()
{
	if !surface_exists(Game.AppSurface)
	{
		Game.AppSurface    = surface_create(Width, Height);
		view_surface_id[0] = Game.AppSurface;
	}
}