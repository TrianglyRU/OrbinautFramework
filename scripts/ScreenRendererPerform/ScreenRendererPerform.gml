function ScreenRendererPerform()
{
	// Use our screen shader
	shader_set(ShaderScreen);
	
	// Render fade
	shader_set_uniform_f(Uniform.Scrn_Step,  Palette.FadeColour == flash ? Palette.FadeStep div 144 * 36 : Palette.FadeStep);
	shader_set_uniform_i(Uniform.Scrn_Color, Palette.FadeColour);
	shader_set_uniform_i(Uniform.Scrn_Mode,  Palette.FadeMode);
	
	// Render surface palette
	if Palette.PaletteSet[PaletteSurface] != false
	{
		shader_set_uniform_f_array(Uniform.Scrn_Index, Palette.PalIndex);
		texture_set_stage(Uniform.Scrn_DynTex, Palette.PaletteSet[0][0]);
		shader_set_uniform_f(Uniform.Scrn_DynTexelSize, Palette.PaletteSet[0][1], Palette.PaletteSet[0][2]);
		shader_set_uniform_f(Uniform.Scrn_DynUVs, Palette.PaletteSet[0][3], Palette.PaletteSet[0][4], Palette.PaletteSet[0][5]);
	}
	
	// Render underwater palette
	if Palette.PaletteSet[PaletteUnderwater] != false
	{
		texture_set_stage(Uniform.Scrn_WetTex, Palette.PaletteSet[1][0]);
		shader_set_uniform_f(Uniform.Scrn_WetTexelSize, Palette.PaletteSet[1][1], Palette.PaletteSet[1][2]);
		shader_set_uniform_f(Uniform.Scrn_WetUVs, Palette.PaletteSet[1][3], Palette.PaletteSet[1][4], Palette.PaletteSet[1][5]);
		shader_set_uniform_f(Uniform.Scrn_Water, instance_exists(Stage) ? clamp(Screen.CameraY - Stage.WaterLevel + Game.ResolutionHeight, 0, Game.ResolutionHeight) : 0);
		shader_set_uniform_f(Uniform.Scrn_WaterCol, 0, 72, 144);
	}
}