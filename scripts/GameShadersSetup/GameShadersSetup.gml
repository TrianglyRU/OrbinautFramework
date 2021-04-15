function GameShadersSetup()
{
	// Setup fade shader
	globalvar Scrn_Step, Scrn_Mode, Scrn_Color;
	
	Scrn_Step  = shader_get_uniform(ShaderScreen, "u_step");
	Scrn_Mode  = shader_get_uniform(ShaderScreen, "u_mode");
	Scrn_Color = shader_get_uniform(ShaderScreen, "u_color");
	
	// Setup palette shader
	globalvar Scrn_DynTexelSize, Scrn_DynUVs, Scrn_DynTex, Scrn_Index, 
			  Scrn_WetTexelSize, Scrn_WetUVs, Scrn_WetTex, Scrn_Water, Scrn_WaterCol;
	
	Scrn_DynTexelSize = shader_get_uniform(ShaderScreen, "u_dynPixelSize");
	Scrn_DynUVs		  = shader_get_uniform(ShaderScreen, "u_dynUvs");
	Scrn_Index	      = shader_get_uniform(ShaderScreen, "u_palId");
	Scrn_DynTex		  = shader_get_sampler_index(ShaderScreen, "u_dynPalTex");
	Scrn_WetTexelSize = shader_get_uniform(ShaderScreen, "u_wetPixelSize");
	Scrn_WetUVs       = shader_get_uniform(ShaderScreen, "u_wetUvs");
	Scrn_Water        = shader_get_uniform(ShaderScreen, "u_water");
	Scrn_WaterCol     = shader_get_uniform(ShaderScreen, "u_waterCol");
	Scrn_WetTex       = shader_get_sampler_index(ShaderScreen, "u_wetPalTex");
	
	// Setup background parallax shader
	globalvar Prlx_XOfst, Prlx_Pos, Prlx_Wid, Prlx_YHght, Prlx_YStep, Prlx_Texel;
	
	Prlx_XOfst = shader_get_uniform(ShaderParallax, "x_ofst");
	Prlx_Pos   = shader_get_uniform(ShaderParallax, "o_pos");
	Prlx_Wid   = shader_get_uniform(ShaderParallax, "wid");
	Prlx_YHght = shader_get_uniform(ShaderParallax, "y_height");
	Prlx_YStep = shader_get_uniform(ShaderParallax, "y_step");
	Prlx_Texel = shader_get_uniform(ShaderParallax, "texel");
}