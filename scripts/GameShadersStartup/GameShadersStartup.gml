function GameShadersStartup()
{
	// Setup palette shader
	Shader.PalStep       = shader_get_uniform(ShaderPalette,	   "u_step");
	Shader.PalMode       = shader_get_uniform(ShaderPalette,	   "u_mode");
	Shader.PalColour     = shader_get_uniform(ShaderPalette,	   "u_colour");
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
	Shader.PrlPos       = shader_get_uniform(ShaderParallax, "u_pos");
	Shader.PrlWidth     = shader_get_uniform(ShaderParallax, "u_width");
	Shader.PrlYScale    = shader_get_uniform(ShaderParallax, "u_yScale");
	Shader.PrlOffset	= shader_get_uniform(ShaderParallax, "u_offset");
	Shader.PrlIncHeight = shader_get_uniform(ShaderParallax, "u_ilHeight");
	Shader.PrlIncStep   = shader_get_uniform(ShaderParallax, "u_ilStep");
	Shader.PrlMapSize   = shader_get_uniform(ShaderParallax, "u_mapSize");
}