function PaletteRendererSurfaceUpdate()
{		
	// If it is playable stage and it is paused, exit
	//if instance_exists(Stage) and Stage.GamePaused exit;
	
	surface_set_target(application_surface);
	
	if surface_exists(SurfaceLow) 
	{
		// Use our screen shader
		shader_set(ShaderScreen);
	
		// Render fade
		shader_set_uniform_f(Shader.Scrn_Step,		 FadeColour == flash ? FadeStep div 144 * 36 : FadeStep);
		shader_set_uniform_i(Shader.Scrn_Color,		 FadeColour);
		shader_set_uniform_i(Shader.Scrn_Mode,		 FadeMode);
		shader_set_uniform_f(Shader.Scrn_ScrnHeight, Game.ResolutionHeight);
	
		// Render surface palette
		if PaletteSet[PaletteSurface] != false
		{
			shader_set_uniform_f_array(Shader.Scrn_DryIndex, PalIndexDry);
			texture_set_stage(Shader.Scrn_DryTex,			 PaletteSet[0][0]);
			shader_set_uniform_f(Shader.Scrn_DryTexelSize,   PaletteSet[0][1], PaletteSet[0][2]);
			shader_set_uniform_f(Shader.Scrn_DryUVs,		 PaletteSet[0][3], PaletteSet[0][4], PaletteSet[0][5]);
		}
	
		// Render underwater palette
		if PaletteSet[PaletteUnderwater] != false
		{
			texture_set_stage(Shader.Scrn_WetTex,			 PaletteSet[1][0]);
			shader_set_uniform_f_array(Shader.Scrn_WetIndex, PalIndexWet);
			shader_set_uniform_f(Shader.Scrn_WetTexelSize,   PaletteSet[1][1], PaletteSet[1][2]);
			shader_set_uniform_f(Shader.Scrn_WetUVs,		 PaletteSet[1][3], PaletteSet[1][4], PaletteSet[1][5]);
			shader_set_uniform_f(Shader.Scrn_Water, instance_exists(Stage) and Stage.WaterEnabled ? clamp(Screen.CameraY - Stage.WaterLevel + Game.ResolutionHeight, 0, Game.ResolutionHeight) : 0);
		}
	
		// Draw surface and reset shader
		draw_surface(SurfaceLow, 0, 0);
		shader_reset();
	}
	
	if surface_exists(SurfaceHigh)
	{
		draw_surface(SurfaceHigh, 0, 0);
	}
	
	surface_reset_target();
}