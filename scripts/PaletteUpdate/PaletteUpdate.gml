function PaletteUpdate()
{	
	// Set application surface as targer surface
	surface_set_target(application_surface);
	draw_clear_alpha(c_white, 0);
	
	// Low surface render
	if surface_exists(Palette.SurfaceLow) 
	{
		// Use screen shader
		shader_set(ShaderScreen);
		
		// Render fade
		shader_set_uniform_f(Shader.ScreenStep,   Palette.FadeColour == flash ? Palette.FadeStep div 3 : Palette.FadeStep);
		shader_set_uniform_i(Shader.ScreenColour, Palette.FadeColour);
		shader_set_uniform_i(Shader.ScreenMode,   Palette.FadeMode);
		
		// Get a render boundary between surface and underwater palette
		var Height   = Game.ResolutionHeight;
		var Boundary = variable_check(Stage, "WaterEnabled") ? Height - clamp(Screen.CameraY - Stage.WaterLevel + Height, 0, Height) : Height;
		
		// Transfer boundary data into the shader
		shader_set_uniform_f(Shader.ScreenWaterHeight, Boundary);
		
		// Render surface palette
		if Boundary > 0 and Palette.ColourSet[PaletteDry] != false
		{
			shader_set_uniform_f_array(Shader.ScreenDryIndex, Palette.IndexDry);
			texture_set_stage(Shader.ScreenDryTex,			  Palette.ColourSet[0][0]);
			shader_set_uniform_f(Shader.ScreenDryTexelSize,   Palette.ColourSet[0][1], Palette.ColourSet[0][2]);
			shader_set_uniform_f(Shader.ScreenDryUVs,		  Palette.ColourSet[0][3], Palette.ColourSet[0][4], Palette.ColourSet[0][5]);
		}
		
		// Render underwater palette
		if Boundary < Height and PaletteSet[PaletteWet] != false
		{
			texture_set_stage(Shader.ScreenWetTex,			  Palette.ColourSet[1][0]);
			shader_set_uniform_f_array(Shader.ScreenWetIndex, Palette.IndexWet);
			shader_set_uniform_f(Shader.ScreenWetTexelSize,   Palette.ColourSet[1][1], Palette.ColourSet[1][2]);
			shader_set_uniform_f(Shader.ScreenWetUVs,		  Palette.ColourSet[1][3], Palette.ColourSet[1][4], Palette.ColourSet[1][5]);
		}
		
		// Render low surface
		draw_surface(Palette.SurfaceLow, 0, 0);
		
		// Reset shader
		shader_reset();
	}
	
	// Render high surface
	if surface_exists(Palette.SurfaceHigh)
	{
		draw_surface(Palette.SurfaceHigh, 0, 0);
	}
	
	// Reset target surface
	surface_reset_target();
}