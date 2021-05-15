function GameShadersSetup()
{
	/* = Fade shader = */
	// =============== //

	// Setup fade shader
	Palette.Scrn_Step  = shader_get_uniform(ShaderScreen, "u_step");
	Palette.Scrn_Mode  = shader_get_uniform(ShaderScreen, "u_mode");
	Palette.Scrn_Color = shader_get_uniform(ShaderScreen, "u_color");
	
	/* = Palette shader = */
	// ================== //
	
	// Setup palette shader
	Palette.Scrn_DynTexelSize = shader_get_uniform(ShaderScreen, "u_dynPixelSize");
	Palette.Scrn_DynUVs		  = shader_get_uniform(ShaderScreen, "u_dynUvs");
	Palette.Scrn_Index	      = shader_get_uniform(ShaderScreen, "u_palId");
	Palette.Scrn_DynTex		  = shader_get_sampler_index(ShaderScreen, "u_dynPalTex");
	Palette.Scrn_WetTexelSize = shader_get_uniform(ShaderScreen, "u_wetPixelSize");
	Palette.Scrn_WetUVs       = shader_get_uniform(ShaderScreen, "u_wetUvs");
	Palette.Scrn_Water        = shader_get_uniform(ShaderScreen, "u_water");
	Palette.Scrn_WaterCol     = shader_get_uniform(ShaderScreen, "u_waterCol");
	Palette.Scrn_WetTex       = shader_get_sampler_index(ShaderScreen, "u_wetPalTex");
	
	/* = Parallax shader = */
	// =================== //

	// Setup background parallax shader
	Palette.Prlx_XOfst = shader_get_uniform(ShaderParallax, "x_ofst");
	Palette.Prlx_Pos   = shader_get_uniform(ShaderParallax, "o_pos");
	Palette.Prlx_Wid   = shader_get_uniform(ShaderParallax, "wid");
	Palette.Prlx_YHght = shader_get_uniform(ShaderParallax, "y_height");
	Palette.Prlx_YStep = shader_get_uniform(ShaderParallax, "y_step");
	Palette.Prlx_Texel = shader_get_uniform(ShaderParallax, "texel");
}