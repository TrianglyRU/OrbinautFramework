function ScreenRendererPerform()
{	
	if surface_exists(Game.AppSurface)
	{
		surface_set_target(Game.AppSurface);
		return true;
	}
	return false;
}