function GameShadersSetup()
{
	/* = Fade shader = */
	// =============== //

	// Setup fade shader
	Uniform.Scrn_Step  = shader_get_uniform(ShaderScreen, "u_step");
	Uniform.Scrn_Mode  = shader_get_uniform(ShaderScreen, "u_mode");
	Uniform.Scrn_Color = shader_get_uniform(ShaderScreen, "u_color");
	
	/* = Palette shader = */
	// ================== //
	
	// Setup palette shader
	Uniform.Scrn_DynTexelSize = shader_get_uniform(ShaderScreen, "u_dynPixelSize");
	Uniform.Scrn_DynUVs		  = shader_get_uniform(ShaderScreen, "u_dynUvs");
	Uniform.Scrn_Index	      = shader_get_uniform(ShaderScreen, "u_palId");
	Uniform.Scrn_DynTex		  = shader_get_sampler_index(ShaderScreen, "u_dynPalTex");
	Uniform.Scrn_WetTexelSize = shader_get_uniform(ShaderScreen, "u_wetPixelSize");
	Uniform.Scrn_WetUVs       = shader_get_uniform(ShaderScreen, "u_wetUvs");
	Uniform.Scrn_Water        = shader_get_uniform(ShaderScreen, "u_water");
	Uniform.Scrn_WaterCol     = shader_get_uniform(ShaderScreen, "u_waterCol");
	Uniform.Scrn_WetTex       = shader_get_sampler_index(ShaderScreen, "u_wetPalTex");
	
	/* = Parallax shader = */
	// =================== //

	// Setup background parallax shader
	Uniform.Prlx_XOfst = shader_get_uniform(ShaderParallax, "x_ofst");
	Uniform.Prlx_Pos   = shader_get_uniform(ShaderParallax, "o_pos");
	Uniform.Prlx_Wid   = shader_get_uniform(ShaderParallax, "wid");
	Uniform.Prlx_YHght = shader_get_uniform(ShaderParallax, "y_height");
	Uniform.Prlx_YStep = shader_get_uniform(ShaderParallax, "y_step");
	Uniform.Prlx_Texel = shader_get_uniform(ShaderParallax, "texel");
	
	/* = Wave shader = */
	// =================== //
	
	// Setup background parallax shader
	Uniform.Wave_Texel = shader_get_uniform(ShaderWave, "u_texel");
	Uniform.Wave_Time  = shader_get_uniform(ShaderWave, "u_time");
	Uniform.Wave_Water = shader_get_uniform(ShaderWave, "u_water");
}