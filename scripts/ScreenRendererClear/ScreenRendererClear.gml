function ScreenRendererClear()
{
	// Clear main surface
	if surface_exists(Game.MainSurf) 
	{
		surface_free(Game.MainSurf);
		Game.MainSurf = -1;
	}
	
	// Clear BG surface
	if surface_exists(Game.BGSurf)
	{
		surface_free(Game.BGSurf);
		Game.BGSurf = -1;
	}
}