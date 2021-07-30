function PaletteRendererSurfaceDraw()
{	
	application_surface_draw_enable(true);
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
	application_surface_draw_enable(false);
}