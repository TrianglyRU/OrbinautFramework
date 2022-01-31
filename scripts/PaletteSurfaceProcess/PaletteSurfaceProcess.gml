function PaletteSurfaceProcess()
{	
	surface_set_target(application_surface);
	draw_clear_alpha(c_white, 0);
	
	if surface_exists(SurfaceLow) 
	{
		// Use shader
		shader_set(ShaderFade);
		
		// Render palette fade
		shader_set_uniform_f(Shader.PalStep,   FadeBlend == BlendFlash ? FadeStep div 3 : FadeStep);
		shader_set_uniform_i(Shader.PalColour, FadeBlend);
		shader_set_uniform_i(Shader.PalMode,   FadeMode);
		/*
		// Define a render boundary between type 1 and type 2 palettes
		if instance_exists(Stage) and Stage.WaterEnabled
		{
			var Boundary = Game.Height - clamp(Camera.ViewY - Stage.WaterLevel + Game.Height, 0, Game.Height);
		}
		else
		{
			var Boundary = Game.Height;
		}
	
		// Transfer boundary data into the shader
		shader_set_uniform_f(Shader.PalBoundary, Boundary);
		
		// Render palette type 1
		if Boundary > 0 and ColourSet[TypePrimary] != false
		{
			shader_set_uniform_f_array(Shader.PalIndex1, IndexType1);
			texture_set_stage(Shader.PalTex1,			 ColourSet[0][0]);
			shader_set_uniform_f(Shader.PalTexelSize1,   ColourSet[0][1], ColourSet[0][2]);
			shader_set_uniform_f(Shader.PalUVs1,		 ColourSet[0][3], ColourSet[0][4], ColourSet[0][5]);
		}
		
		// Render palette type 2
		if Boundary < Game.Height and ColourSet[TypeSecondary] != false
		{
			texture_set_stage(Shader.PalTex2,			 ColourSet[1][0]);
			shader_set_uniform_f_array(Shader.PalIndex2, IndexType2);
			shader_set_uniform_f(Shader.PalTexelSize2,   ColourSet[1][1], ColourSet[1][2]);
			shader_set_uniform_f(Shader.PalUVs2,		 ColourSet[1][3], ColourSet[1][4], ColourSet[1][5]);
		}
		*/
		// Render first palette surface
		draw_surface(SurfaceLow, 0, 0);
		shader_reset();
	}
	
	// Render second palette surface
	if surface_exists(SurfaceHigh)
	{
		draw_surface(SurfaceHigh, 0, 0);
	}
	surface_reset_target();
	application_surface_draw_enable(true);
	
	// Draw application (game) surface
	draw_surface(application_surface, 0, 0); application_surface_draw_enable(false);
}