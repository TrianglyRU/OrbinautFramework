/// @description Process Surfaces
// You can write your code in this editor
	
	gpu_set_blendenable(false);
	surface_set_target(application_surface);
	
	// Render first surface
	if surface_exists(SurfaceLow)
	{
		shader_set(ShaderFade);
		{
			shader_set_uniform_f(Shader.PalFadeValue,  Palette.FadeBlend == BlendFlash ? Palette.FadeValue div 3 : Palette.FadeValue);
			shader_set_uniform_i(Shader.PalFadeColour, Palette.FadeBlend);
			shader_set_uniform_i(Shader.PalFadeMode,   Palette.FadeMode);
			
			draw_surface(SurfaceLow, -global.ScreenBuffer, 0);
		}
		shader_reset();
	}
	
	// Render second surface
	if surface_exists(SurfaceHigh)
	{
		draw_surface(SurfaceHigh, 0, 0);
	}
		
	surface_reset_target();
	application_surface_draw_enable(true);
	
	// Draw application (game) surface
	draw_surface(application_surface, 0, 0); application_surface_draw_enable(false);
	gpu_set_blendenable(true);