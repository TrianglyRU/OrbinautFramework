function GameRendererUpdate()
{
	/* Game render is mostly based on palette shader, so it is core
	of the renderer */
	
	// Use our palette shader
	shader_set(ShaderScreen);
	
	// Do shader math
	shader_set_uniform_f(Scrn_Step,  Game.FadeColour == flash ? Game.FadeStep div 144 * 36 : Game.FadeStep);
	shader_set_uniform_i(Scrn_Color, Game.FadeColour);
	shader_set_uniform_i(Scrn_Mode,  Game.FadeMode);
	
	shader_set_uniform_f_array(Scrn_Index, Game.PalIndex);
	texture_set_stage(Scrn_DynTex, Game.PaletteSet[0][0]);
	shader_set_uniform_f(Scrn_DynTexelSize, Game.PaletteSet[0][1], Game.PaletteSet[0][2]);
	shader_set_uniform_f(Scrn_DynUVs, Game.PaletteSet[0][3], Game.PaletteSet[0][4], Game.PaletteSet[0][5]);
	
	if Game.PaletteSet[1] != false
	{
		texture_set_stage(Scrn_WetTex, Game.PaletteSet[1][0]);
		shader_set_uniform_f(Scrn_WetTexelSize, Game.PaletteSet[1][1], Game.PaletteSet[1][2]);
		shader_set_uniform_f(Scrn_WetUVs, Game.PaletteSet[1][3], Game.PaletteSet[1][4], Game.PaletteSet[1][5]);
		shader_set_uniform_f(Scrn_Water, instance_exists(Stage) ? clamp(Screen.RenderY - Stage.WaterLevel + Game.ResolutionHeight, 0, Game.ResolutionHeight) : 0);
		shader_set_uniform_f(Scrn_WaterCol, 0, 72, 144);
	}
	
	// Draw our surface
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);
	
	// Reset renderer
	shader_reset();
}