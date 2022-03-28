function GameShadersStartup()
{
	// Setup fade module
	Shader.PalStep       = shader_get_uniform(ShaderFade, "u_step");
	Shader.PalMode       = shader_get_uniform(ShaderFade, "u_mode");
	Shader.PalColour     = shader_get_uniform(ShaderFade, "u_colour");
	
	// Setup palette module
	Shader.PalBoundary   = shader_get_uniform(ShaderMain,	    "u_bound");
	Shader.PalTexelSize1 = shader_get_uniform(ShaderMain,	    "u_texSizeFst");
	Shader.PalUVs1	     = shader_get_uniform(ShaderMain,	    "u_UVsFst");
	Shader.PalIndex1	 = shader_get_uniform(ShaderMain,	    "u_indFst");
	Shader.PalTex1		 = shader_get_sampler_index(ShaderMain, "u_texFst");
	Shader.PalTexelSize2 = shader_get_uniform(ShaderMain,	    "u_texSizeSnd");
	Shader.PalUVs2       = shader_get_uniform(ShaderMain,	    "u_UVsSnd");
	Shader.PalIndex2	 = shader_get_uniform(ShaderMain,	    "u_indSnd");
	Shader.PalTex2       = shader_get_sampler_index(ShaderMain, "u_texSnd");

	// Setup parallax module
	Shader.PrlActive    = shader_get_uniform(ShaderMain, "u_parallaxActive");
	Shader.PrlPos       = shader_get_uniform(ShaderMain, "u_pos");
	Shader.PrlWidth     = shader_get_uniform(ShaderMain, "u_width");
	Shader.PrlYScale    = shader_get_uniform(ShaderMain, "u_yScale");
	Shader.PrlOffset	= shader_get_uniform(ShaderMain, "u_offset");
	Shader.PrlIncHeight = shader_get_uniform(ShaderMain, "u_ilHeight");
	Shader.PrlIncStep   = shader_get_uniform(ShaderMain, "u_ilStep");
	Shader.PrlMapSize   = shader_get_uniform(ShaderMain, "u_mapSize");
	Shader.PrlOriginY   = shader_get_uniform(ShaderMain, "u_originY");
}