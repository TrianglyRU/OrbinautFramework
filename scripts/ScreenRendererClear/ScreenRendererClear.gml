function ScreenRendererClear()
{
	// Clear main surface
	if surface_exists(Game.AppSurface) 
	{
		surface_free(Game.AppSurface);
		Game.AppSurface = -1;
	}
}