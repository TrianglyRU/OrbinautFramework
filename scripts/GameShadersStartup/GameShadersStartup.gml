function GameShadersStartup()
{
	// Setup flash shader
	Shader.FlashType = shader_get_uniform(ShaderFlash, "u_type");
	
	// Setup fade shader
	Shader.ScreenStep   = shader_get_uniform(ShaderScreen, "u_step");
	Shader.ScreenMode   = shader_get_uniform(ShaderScreen, "u_mode");
	Shader.ScreenColour = shader_get_uniform(ShaderScreen, "u_colour");
	
	// Setup palette shader
	Shader.ScreenWaterHeight  = shader_get_uniform(ShaderScreen, "u_waterHeight");
	Shader.ScreenDryTexelSize = shader_get_uniform(ShaderScreen, "u_dryPixelSize");
	Shader.ScreenDryUVs		  = shader_get_uniform(ShaderScreen, "u_dryUvs");
	Shader.ScreenDryIndex	  = shader_get_uniform(ShaderScreen, "u_dryPalId");
	Shader.ScreenDryTex		  = shader_get_sampler_index(ShaderScreen, "u_dryPalTex");
	Shader.ScreenWetTexelSize = shader_get_uniform(ShaderScreen, "u_wetPixelSize");
	Shader.ScreenWetUVs       = shader_get_uniform(ShaderScreen, "u_wetUvs");
	Shader.ScreenWetIndex	  = shader_get_uniform(ShaderScreen, "u_wetPalId");
	Shader.ScreenWetTex       = shader_get_sampler_index(ShaderScreen, "u_wetPalTex");

	// Setup parallax shader
	Shader.ParPos       = shader_get_uniform(ShaderParallax, "u_pos");
	Shader.ParWidth     = shader_get_uniform(ShaderParallax, "u_width");
	Shader.ParYScale    = shader_get_uniform(ShaderParallax, "u_yScale");
	Shader.ParOffset	= shader_get_uniform(ShaderParallax, "u_offset");
	Shader.ParILHeight  = shader_get_uniform(ShaderParallax, "u_ilHeight");
	Shader.ParILStep    = shader_get_uniform(ShaderParallax, "u_ilStep");
	Shader.ParPixelSize = shader_get_uniform(ShaderParallax, "u_pixelSize");
}