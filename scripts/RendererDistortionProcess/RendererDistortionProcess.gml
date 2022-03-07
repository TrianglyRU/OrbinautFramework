function RendererDistortionProcess()
{		
	// Loop through FG and BG distortion effects
	for (var i = 0; i < 2; i++)
	{
		if DistortionEffect[i] != noone
		{
			if !DistortionMode[i] and Stage.UpdateObjects
			or  DistortionMode[i] and Renderer.UpdateAnimations
			{
				// Count time (basically, it is the speed of the distortion effect)
				DistortionShift[i][0] += DistortionSpeed[i][0];
				DistortionShift[i][1] += DistortionSpeed[i][1];
			}
			
			for (var j = 0; j < 2; j++)
			{
				// Set split boundary
				if DistortionEnabled[i][j]
				{
					if j == 1 or !DistortionMode[i]
					{
						var Height = global.Height;
						var Bound  = Height - clamp(Camera.ViewY - Stage.WaterLevel + Height, 0, Height);
					}
					else
					{
						var Bound = room_height;
					}
				}
				else
				{
					var Bound = j ? room_height : 0;
				}
				fx_set_parameter(DistortionEffect[i], "g_Bound" + string(j + 2), Bound);
				
				// Set position
				if i == 1 and array_length(Background.BGSprites)
				{
					fx_set_parameter(DistortionEffect[i], "g_WaveY" + string(j + 1), floor(DistortionShift[i][j] + Camera.ViewY * Background.BGValues[0][4]));
				}
				else
				{
					fx_set_parameter(DistortionEffect[i], "g_WaveY" + string(j + 1), floor(DistortionShift[i][j] + Camera.ViewY));
				}
			}
		}
	}
}