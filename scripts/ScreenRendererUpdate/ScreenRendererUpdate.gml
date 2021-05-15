function ScreenRendererUpdate()
{
	surface_reset_target();
	
	// Draw application surface
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);
	
	// Reset renderer
	shader_reset();
}