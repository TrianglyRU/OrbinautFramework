function ScreenRendererClear()
{
	// Clear main surface
	if surface_exists(Game.MainSurf) 
	{
		surface_free(Game.MainSurf);
		Game.MainSurf = -1;
	}
}