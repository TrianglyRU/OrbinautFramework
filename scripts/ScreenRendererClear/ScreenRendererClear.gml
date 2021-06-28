function ScreenRendererClear()
{
	// Clear main surface
	if surface_exists(AppSurface) 
	{
		surface_free(AppSurface);
		AppSurface = -1;
	}
}