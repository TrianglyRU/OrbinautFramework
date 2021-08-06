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
		shader_set_uniform_f(Shader.Scrn_Step,  FadeColour == flash ? FadeStep div 144 * 36 : FadeStep);
		shader_set_uniform_i(Shader.Scrn_Color, FadeColour);
		shader_set_uniform_i(Shader.Scrn_Mode,  FadeMode);
		
		// Get a render boundary between surface and underwater palette
		var Height   = Game.ResolutionHeight;
		var Boundary = instance_exists(Stage) and Stage.WaterEnabled ? Height - clamp(Screen.CameraY - Stage.WaterLevel + Height, 0, Height) : Height;
		
		// Transfer boundary data into the shader
		shader_set_uniform_f(Shader.Scrn_WaterHeight, Boundary);
		
		// Render surface palette
		if Boundary > 0 and PaletteSet[PaletteDry] != false
		{
			shader_set_uniform_f_array(Shader.Scrn_DryIndex, PaletteIndexDry);
			texture_set_stage(Shader.Scrn_DryTex,			 PaletteSet[0][0]);
			shader_set_uniform_f(Shader.Scrn_DryTexelSize,   PaletteSet[0][1], PaletteSet[0][2]);
			shader_set_uniform_f(Shader.Scrn_DryUVs,		 PaletteSet[0][3], PaletteSet[0][4], PaletteSet[0][5]);
		}
		
		// Render underwater palette
		if Boundary < Height and PaletteSet[PaletteWet] != false
		{
			texture_set_stage(Shader.Scrn_WetTex,			 PaletteSet[1][0]);
			shader_set_uniform_f_array(Shader.Scrn_WetIndex, PaletteIndexWet);
			shader_set_uniform_f(Shader.Scrn_WetTexelSize,   PaletteSet[1][1], PaletteSet[1][2]);
			shader_set_uniform_f(Shader.Scrn_WetUVs,		 PaletteSet[1][3], PaletteSet[1][4], PaletteSet[1][5]);
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