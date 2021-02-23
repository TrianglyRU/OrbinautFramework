function GameShadersSetup()
{
	// Setup fade shader
	globalvar Scrn_Step, Scrn_Mode, Scrn_Color;
	Scrn_Step  = shader_get_uniform(ShaderPalette, "u_step");
	Scrn_Mode  = shader_get_uniform(ShaderPalette, "u_mode");
	Scrn_Color = shader_get_uniform(ShaderPalette, "u_color");
	
	// Setup palette shader
	globalvar Scrn_Texel_Size, Scrn_UVs, Scrn_Index, Scrn_Texture;
	Scrn_Texel_Size = shader_get_uniform(ShaderPalette, "u_pixelSize");
	Scrn_UVs		= shader_get_uniform(ShaderPalette, "u_Uvs");
	Scrn_Index	    = shader_get_uniform(ShaderPalette, "u_palId");
	Scrn_Texture    = shader_get_sampler_index(ShaderPalette, "u_palTexture");
	
	// Setup background parallax shader
	globalvar Prlx_XOfst, Prlx_Pos, Prlx_Wid, Prlx_YHght, Prlx_YStep, Prlx_Texel;
	Prlx_XOfst = shader_get_uniform(ShaderParallax, "x_ofst");
	Prlx_Pos   = shader_get_uniform(ShaderParallax, "o_pos");
	Prlx_Wid   = shader_get_uniform(ShaderParallax, "wid");
	Prlx_YHght = shader_get_uniform(ShaderParallax, "y_height");
	Prlx_YStep = shader_get_uniform(ShaderParallax, "y_step");
	Prlx_Texel = shader_get_uniform(ShaderParallax, "texel");
}