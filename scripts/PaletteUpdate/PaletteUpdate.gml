function PaletteUpdate()
{	
	// Set application surface as targer surface
	surface_set_target(application_surface);
	draw_clear_alpha(c_white, 0);
	
	// Low surface render
	if surface_exists(SurfaceLow) 
	{
		// Use screen shader
		shader_set(ShaderScreen);
		
		// Render fade
		shader_set_uniform_f(Shader.ScreenStep,   FadeColour == FadeFlash ? FadeStep div 3 : FadeStep);
		shader_set_uniform_i(Shader.ScreenColour, FadeColour);
		shader_set_uniform_i(Shader.ScreenMode,   FadeMode);
		
		// Get a render boundary between surface and underwater palette
		var Height   = Game.Height;
		var Boundary = variable_check(Stage, "WaterEnabled") ? Height - clamp(Camera.ViewY - Stage.WaterLevel + Height, 0, Height) : Height;
		
		// Transfer boundary data into the shader
		shader_set_uniform_f(Shader.ScreenWaterHeight, Boundary);
		
		// Render surface palette
		if Boundary > 0 and ColourSet[PaletteDry] != false
		{
			shader_set_uniform_f_array(Shader.ScreenDryIndex, IndexDry);
			texture_set_stage(Shader.ScreenDryTex,			  ColourSet[0][0]);
			shader_set_uniform_f(Shader.ScreenDryTexelSize,   ColourSet[0][1], ColourSet[0][2]);
			shader_set_uniform_f(Shader.ScreenDryUVs,		  ColourSet[0][3], ColourSet[0][4], ColourSet[0][5]);
		}
		
		// Render underwater palette
		if Boundary < Height and ColourSet[PaletteWet] != false
		{
			texture_set_stage(Shader.ScreenWetTex,			 ColourSet[1][0]);
			shader_set_uniform_f_array(Shader.ScreenWetIndex, IndexWet);
			shader_set_uniform_f(Shader.ScreenWetTexelSize,   ColourSet[1][1], ColourSet[1][2]);
			shader_set_uniform_f(Shader.ScreenWetUVs,		 ColourSet[1][3], ColourSet[1][4], ColourSet[1][5]);
		}
		
		// Render low surface
		draw_surface(SurfaceLow, 0, 0);
		
		// Reset shader
		shader_reset();
	}
	
	// Render high surface
	if surface_exists(SurfaceHigh)
	{
		draw_surface(SurfaceHigh, 0, 0);
	}
	
	// Reset target surface
	surface_reset_target();
}