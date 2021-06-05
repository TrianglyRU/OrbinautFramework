function ScreenRendererClear()
{
	// Clear main surface
	if surface_exists(GameSurf) 
	{
		surface_free(GameSurf);
	}
	
	// Clear BG surface
	if surface_exists(BGSurf)
	{
		surface_free(BGSurf);
	}
}