function ScreenRendererPerform()
{	
	var surfExists = surface_exists(Game.AppSurface);
	if (surfExists) draw_surface(Game.AppSurface, 0, 0);
	surface_set_target(Game.AppSurface);
	return surfExists;
}