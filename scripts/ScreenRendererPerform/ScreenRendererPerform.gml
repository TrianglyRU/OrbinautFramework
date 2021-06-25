function ScreenRendererPerform()
{	
	var surfExists = surface_exists(Game.MainSurf);
	if (surfExists) draw_surface(Game.MainSurf, 0, 0);
	surface_set_target(Game.MainSurf);
	return surfExists;
}