function ScreenRendererClear()
{
	// Clear complete surface
	if surface_exists(Game.CompleteSurf)
	{
		surface_free(Game.CompleteSurf);
		Game.CompleteSurf = -1;
	}
	
	// Clear main surface
	if surface_exists(Game.MainSurf) 
	{
		surface_free(Game.MainSurf);
		Game.MainSurf = -1;
	}
	
	// Clear background surface
	if surface_exists(Game.BGSurf)
	{
		surface_free(Game.BGSurf);
		Game.BGSurf = -1;
	}
}