function GameShadersSetup()
{
	// Setup fade shader
	Shader.Scrn_Step  = shader_get_uniform(ShaderScreen, "u_step");
	Shader.Scrn_Mode  = shader_get_uniform(ShaderScreen, "u_mode");
	Shader.Scrn_Color = shader_get_uniform(ShaderScreen, "u_color");
	
	// Setup palette shader
	Shader.Scrn_ScrnHeight	 = shader_get_uniform(ShaderScreen, "u_scrnHeight");
	Shader.Scrn_DryTexelSize = shader_get_uniform(ShaderScreen, "u_dryPixelSize");
	Shader.Scrn_DryUVs		 = shader_get_uniform(ShaderScreen, "u_dryUvs");
	Shader.Scrn_DryIndex	 = shader_get_uniform(ShaderScreen, "u_dryPalId");
	Shader.Scrn_DryTex		 = shader_get_sampler_index(ShaderScreen, "u_dryPalTex");
	Shader.Scrn_WetTexelSize = shader_get_uniform(ShaderScreen, "u_wetPixelSize");
	Shader.Scrn_WetUVs       = shader_get_uniform(ShaderScreen, "u_wetUvs");
	Shader.Scrn_WetIndex	 = shader_get_uniform(ShaderScreen, "u_wetPalId");
	Shader.Scrn_Water        = shader_get_uniform(ShaderScreen, "u_water");
	Shader.Scrn_WetTex       = shader_get_sampler_index(ShaderScreen, "u_wetPalTex");

	// Setup background parallax shader
	Shader.Prlx_XOfst = shader_get_uniform(ShaderParallax, "x_ofst");
	Shader.Prlx_Pos   = shader_get_uniform(ShaderParallax, "o_pos");
	Shader.Prlx_Wid   = shader_get_uniform(ShaderParallax, "wid");
	Shader.Prlx_YHght = shader_get_uniform(ShaderParallax, "y_height");
	Shader.Prlx_YStep = shader_get_uniform(ShaderParallax, "y_step");
	Shader.Prlx_Texel = shader_get_uniform(ShaderParallax, "texel");
}