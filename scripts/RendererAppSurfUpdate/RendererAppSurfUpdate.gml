function RendererAppSurfUpdate()
{	
	/*if keyboard_check(ord("A"))
	{
		shader_set(ShaderPostProcessing);
		application_surface_draw_enable(true);
		draw_surface(application_surface, 0, 0);
		application_surface_draw_enable(false);
		shader_reset();
	}
	else
	{
		application_surface_draw_enable(true);
		draw_surface(application_surface, 0, 0);
		application_surface_draw_enable(false);
	}
	*/
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);
}