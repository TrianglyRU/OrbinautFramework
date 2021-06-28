function ScreenRendererPerform()
{	
	if surface_exists(AppSurface)
	{
		surface_set_target(AppSurface);
		return true;
	}
	return false;
}