function RendererDistortionProcess()
{		
	for (var j = 0; j < 2; j++)
	{
		if DistortionEffect[j] != noone
		{
			// Count time (basically, it is the speed of the distortion effect)
			if !DistortionMode[j] and Stage.UpdateObjects
			or  DistortionMode[j] and Renderer.UpdateAnimations
			{
				DistortionPos[j][0] += DistortionSpeed[j][0];
				DistortionPos[j][1] += DistortionSpeed[j][1];
			}
	
			// Update effects
			for (var i = 0; i < 2; i++)
			{
				if DistortionEnabled[j][i]
				{
					if i == 1 or !DistortionMode[j]
					{
						var Height = global.Height;
						var Bound = Height - clamp(Camera.ViewY - Stage.WaterLevel + Height, 0, Height);
					}
					else
					{
						var Bound = room_height;
					}
				}
				else
				{
					var Bound = i ? room_height : 0;
				}
				fx_set_parameter(DistortionEffect[j], "g_WaveY" + string(i + 1), floor(DistortionPos[j][i] + Camera.ViewY));
				fx_set_parameter(DistortionEffect[j], "g_Bound" + string(i + 1), Bound);
			}
		}
	}
}