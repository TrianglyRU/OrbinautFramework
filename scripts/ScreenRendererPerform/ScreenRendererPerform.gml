function ScreenRendererPerform()
{
	if !surface_exists(Game.CompleteSurf) return false;
	
	surface_set_target(Game.CompleteSurf);
	
	if surface_exists(Game.BGSurf)
	{
		draw_surface(Game.BGSurf, 0, 0);
	}
	
	if surface_exists(Game.MainSurf) 
	{
		shader_set(ShaderWave);
		var stg = instance_exists(Stage) and Stage.WaterEnabled;
		shader_set_uniform_f(Uniform.Wave_Texel, GSTexel);
		shader_set_uniform_f(Uniform.Wave_Time,  stg ? Stage.Time div 2 : 0);
		shader_set_uniform_f(Uniform.Wave_Water, stg ? clamp(CameraY - Stage.WaterLevel + Height, 0, Height) : 0);
		shader_set_uniform_f(Uniform.Wave_CamY, CameraY);
		shader_set_uniform_f(Uniform.Wave_ScrnHeight, Height);
		draw_surface(Game.MainSurf, -8, 0);
		shader_reset();
	}
		
	// Use our screen shader
	shader_set(ShaderScreen);
	
	// Render fade
	shader_set_uniform_f(Uniform.Scrn_Step,  Palette.FadeColour == flash ? Palette.FadeStep div 144 * 36 : Palette.FadeStep);
	shader_set_uniform_i(Uniform.Scrn_Color, Palette.FadeColour);
	shader_set_uniform_i(Uniform.Scrn_Mode,  Palette.FadeMode);
	shader_set_uniform_f(Uniform.Scrn_ScrnHeight, Height);
	
	// Render surface palette
	if Palette.PaletteSet[PaletteSurface] != false
	{
		shader_set_uniform_f_array(Uniform.Scrn_DryIndex, Palette.PalIndexDry);
		texture_set_stage(Uniform.Scrn_DryTex, Palette.PaletteSet[0][0]);
		shader_set_uniform_f(Uniform.Scrn_DryTexelSize, Palette.PaletteSet[0][1], Palette.PaletteSet[0][2]);
		shader_set_uniform_f(Uniform.Scrn_DryUVs, Palette.PaletteSet[0][3], Palette.PaletteSet[0][4], Palette.PaletteSet[0][5]);
	}
	
	// Render underwater palette
	if Palette.PaletteSet[PaletteUnderwater] != false
	{
		texture_set_stage(Uniform.Scrn_WetTex, Palette.PaletteSet[1][0]);
		shader_set_uniform_f_array(Uniform.Scrn_WetIndex, Palette.PalIndexWet);
		shader_set_uniform_f(Uniform.Scrn_WetTexelSize, Palette.PaletteSet[1][1], Palette.PaletteSet[1][2]);
		shader_set_uniform_f(Uniform.Scrn_WetUVs, Palette.PaletteSet[1][3], Palette.PaletteSet[1][4], Palette.PaletteSet[1][5]);
		shader_set_uniform_f(Uniform.Scrn_Water, instance_exists(Stage) and Stage.WaterEnabled ? clamp(Screen.CameraY - Stage.WaterLevel + Height, 0, Height) : 0);
	}
}