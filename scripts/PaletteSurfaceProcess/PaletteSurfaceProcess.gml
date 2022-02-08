function PaletteSurfaceProcess()
{	
	gpu_set_blendenable(false);
	{
		surface_set_target(application_surface);
	
		if surface_exists(SurfaceLow) 
		{
			// Use shader
			shader_set(ShaderFade);
		
			// Render palette fade
			shader_set_uniform_f(Shader.PalStep,   FadeBlend == BlendFlash ? FadeStep div 3 : FadeStep);
			shader_set_uniform_i(Shader.PalColour, FadeBlend);
			shader_set_uniform_i(Shader.PalMode,   FadeMode);
			
			// Render first palette surface
			draw_surface(SurfaceLow, 0, 0);
			shader_reset();
		}
	
		// Render second palette surface
		if surface_exists(SurfaceHigh)
		{
			draw_surface(SurfaceHigh, 0, 0);
		}
		surface_reset_target();
		application_surface_draw_enable(true);
	
		// Draw application (game) surface
		draw_surface(application_surface, 0, 0); application_surface_draw_enable(false);
	}
	gpu_set_blendenable(true);
}