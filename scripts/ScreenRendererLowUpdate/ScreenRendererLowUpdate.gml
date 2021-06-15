function ScreenRendererLowUpdate()
{
	surface_reset_target();
		
		surface_set_target(application_surface);
		draw_surface(Game.CompleteSurf, 0, 0);
		shader_reset();
}