function ScreenSurfaceCreate()
{
	if !surface_exists(AppSurface)
	{
		AppSurface = surface_create(Width, Height);
		view_surface_id[0] = AppSurface;
	}
}