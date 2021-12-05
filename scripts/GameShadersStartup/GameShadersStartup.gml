function GameShadersStartup()
{
	// Setup fade shader
	Shader.ScreenStep   = shader_get_uniform(ShaderPalette, "u_step");
	Shader.ScreenMode   = shader_get_uniform(ShaderPalette, "u_mode");
	Shader.ScreenColour = shader_get_uniform(ShaderPalette, "u_colour");
	
	// Setup palette shader
	Shader.ScreenWaterHeight  = shader_get_uniform(ShaderPalette, "u_waterHeight");
	Shader.ScreenDryTexelSize = shader_get_uniform(ShaderPalette, "u_dryPixelSize");
	Shader.ScreenDryUVs		  = shader_get_uniform(ShaderPalette, "u_dryUvs");
	Shader.ScreenDryIndex	  = shader_get_uniform(ShaderPalette, "u_dryPalId");
	Shader.ScreenDryTex		  = shader_get_sampler_index(ShaderPalette, "u_dryPalTex");
	Shader.ScreenWetTexelSize = shader_get_uniform(ShaderPalette, "u_wetPixelSize");
	Shader.ScreenWetUVs       = shader_get_uniform(ShaderPalette, "u_wetUvs");
	Shader.ScreenWetIndex	  = shader_get_uniform(ShaderPalette, "u_wetPalId");
	Shader.ScreenWetTex       = shader_get_sampler_index(ShaderPalette, "u_wetPalTex");

	// Setup parallax shader
	Shader.ParPos       = shader_get_uniform(ShaderParallax, "u_pos");
	Shader.ParWidth     = shader_get_uniform(ShaderParallax, "u_width");
	Shader.ParYScale    = shader_get_uniform(ShaderParallax, "u_yScale");
	Shader.ParOffset	= shader_get_uniform(ShaderParallax, "u_offset");
	Shader.ParILHeight  = shader_get_uniform(ShaderParallax, "u_ilHeight");
	Shader.ParILStep    = shader_get_uniform(ShaderParallax, "u_ilStep");
	Shader.ParMapSize   = shader_get_uniform(ShaderParallax, "u_mapSize");
}