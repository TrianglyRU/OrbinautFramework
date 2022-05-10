/// @description Process Swap and Fade
// You can write your code in this editor
	
	#region Process Swap
	{
		// Define a render boundary between type 1 and type 2 palettes
		if instance_exists(Stage) and Stage.WaterEnabled
		{
			var Boundary = global.Height - clamp(Camera.ViewY - Stage.WaterLevel + global.Height, 0, global.Height);
		}
		else
		{
			var Boundary = global.Height;
		}
		shader_set_uniform_f(Shader.PalBoundary, Boundary);
		
		// Render palette type 1
		if Boundary > 0 and ColourSet[PalPrimary] != false
		{
			texture_set_stage(Shader.PalTex1,			 ColourSet[0][0]);
			shader_set_uniform_f(Shader.PalTexelSize1,   ColourSet[0][1], ColourSet[0][2]);
			shader_set_uniform_f(Shader.PalUVs1,		 ColourSet[0][3], ColourSet[0][4], ColourSet[0][5]);
			shader_set_uniform_f_array(Shader.PalIndex1, IndexType1);
		}
		
		// Render palette type 2
		if Boundary < global.Height and ColourSet[PalSecondary] != false
		{
			texture_set_stage(Shader.PalTex2,			 ColourSet[1][0]);
			shader_set_uniform_f(Shader.PalTexelSize2,   ColourSet[1][1], ColourSet[1][2]);
			shader_set_uniform_f(Shader.PalUVs2,		 ColourSet[1][3], ColourSet[1][4], ColourSet[1][5]);
			shader_set_uniform_f_array(Shader.PalIndex2, IndexType2);
		}
	}
	#endregion
	
	#region Process Fade
	{
		// Update flag
		if FadeValue == 0
		{
			FadeFlag = StateMax;
		}
		else if FadeValue < 756
		{
			FadeFlag = StateActive;
		}
		else
		{
			FadeFlag = false;
		}
		
		// Update value
		if FadeMode and FadeValue < 756
		{
			FadeValue = min(FadeValue + FadeSpeed, 756);
		}
		else if !FadeMode and FadeValue > 0
		{
			FadeValue = max(FadeValue - FadeSpeed, 0);
		}
	}
	#endregion
