function GameRendererUpdate()
{
	// Set shader
	shader_set(ShaderPalette);
	
	// Config uniforms
	shader_set_uniform_f(Scrn_Step,  Game.FadeColour == flash ? Game.FadeStep div 144 * 36 : Game.FadeStep);
	shader_set_uniform_i(Scrn_Color, Game.FadeColour);
	shader_set_uniform_i(Scrn_Mode,  Game.FadeMode);
	shader_set_uniform_f_array(Scrn_Index, Game.PalIndex);

	// Palette shifting code
	var tex = sprite_get_texture(Game.PaletteSet, 0);
	var UVs = sprite_get_uvs(Game.PaletteSet, 0);
	texture_set_stage(Scrn_Texture, tex);
    
	var texel_x = texture_get_texel_width(tex);
	var texel_y = texture_get_texel_height(tex);
	var texel_hx = texel_x * 0.5;
	var texel_hy = texel_y * 0.5;
    
	shader_set_uniform_f(Scrn_Texel_Size, texel_x, texel_y);
	shader_set_uniform_f(Scrn_UVs, UVs[0] + texel_hx, UVs[1] + texel_hy, UVs[2], UVs[3]);
	
	// Draw surface
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);
	
	// Reset
	shader_reset();
}