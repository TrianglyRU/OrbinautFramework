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
	
	shader_set_uniform_f(Scrn_Water, instance_exists(Stage) ? clamp(Screen.RenderY - Stage.WaterLevel + Game.ResolutionHeight, 0, Game.ResolutionHeight) : 0);
	shader_set_uniform_f(Scrn_WaterCol, 0, 72, 144);
	
	shader_set_uniform_f_array(Scrn_Index, Game.PalIndex);
	texture_set_stage(Scrn_Texture, Game.PaletteSet[1]);
    
	shader_set_uniform_f(Scrn_Texel_Size, Game.PaletteSet[2], Game.PaletteSet[3]);
	shader_set_uniform_f(Scrn_UVs, Game.PaletteSet[4], Game.PaletteSet[5], Game.PaletteSet[6], Game.PaletteSet[7]);
	
	// Draw our surface
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);
	
	// Reset renderer
	shader_reset();
}