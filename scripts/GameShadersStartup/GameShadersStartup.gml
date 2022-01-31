function GameShadersStartup()
{
	// Setup fade shader
	Shader.PalStep       = shader_get_uniform(ShaderFade, "u_step");
	Shader.PalMode       = shader_get_uniform(ShaderFade, "u_mode");
	Shader.PalColour     = shader_get_uniform(ShaderFade, "u_colour");
	
	// Setup palette shader
	Shader.PalBoundary   = shader_get_uniform(ShaderPalette,	   "u_bound");
	Shader.PalTexelSize1 = shader_get_uniform(ShaderPalette,	   "u_texSizeFst");
	Shader.PalUVs1	     = shader_get_uniform(ShaderPalette,	   "u_UVsFst");
	Shader.PalIndex1	 = shader_get_uniform(ShaderPalette,	   "u_indFst");
	Shader.PalTex1		 = shader_get_sampler_index(ShaderPalette, "u_texFst");
	Shader.PalTexelSize2 = shader_get_uniform(ShaderPalette,	   "u_texSizeSnd");
	Shader.PalUVs2       = shader_get_uniform(ShaderPalette,	   "u_UVsSnd");
	Shader.PalIndex2	 = shader_get_uniform(ShaderPalette,	   "u_indSnd");
	Shader.PalTex2       = shader_get_sampler_index(ShaderPalette, "u_texSnd");

	// Setup parallax shader
	Shader.PrlActive    = shader_get_uniform(ShaderPalette, "u_parallaxActive");
	Shader.PrlPos       = shader_get_uniform(ShaderPalette, "u_pos");
	Shader.PrlWidth     = shader_get_uniform(ShaderPalette, "u_width");
	Shader.PrlYScale    = shader_get_uniform(ShaderPalette, "u_yScale");
	Shader.PrlOffset	= shader_get_uniform(ShaderPalette, "u_offset");
	Shader.PrlIncHeight = shader_get_uniform(ShaderPalette, "u_ilHeight");
	Shader.PrlIncStep   = shader_get_uniform(ShaderPalette, "u_ilStep");
	Shader.PrlMapSize   = shader_get_uniform(ShaderPalette, "u_mapSize");
}