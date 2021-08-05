function PaletteSurfaceProcess()
{	
	// Re-enable surface rendering
	application_surface_draw_enable(true);
	
	// Render application surface (and apply post-processing shader if enabled)
	if Game.PostProcessing
	{
		shader_set(ShaderPostProcessing);
		draw_surface(application_surface, 0, 0);
		shader_reset();
	}
	else
	{
		draw_surface(application_surface, 0, 0);
	}
	
	// Disable surface rendering
	application_surface_draw_enable(false);
}