function RendererDistortionProcess()
{		
	if DistortionEffect == noone
	{
		return;
	}
	
	// Count time (basically, it is the speed of the distortion effect)
	if !DistortionMode and Stage.UpdateObjects
	or  DistortionMode and Renderer.UpdateAnimations
	{
		DistortionTimer += 0.5;
	}
	
	// Update effects
	for (var i = 0; i < 2; i++)
	{
		if DistortionEnabled[i]
		{
			if i == 1 or !DistortionMode
			{
				var Bound = global.Height - clamp(Camera.ViewY - Stage.WaterLevel + global.Height, 0, global.Height);
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
		fx_set_parameter(DistortionEffect, "g_WaveY" + string(i + 1), floor(DistortionTimer + Camera.ViewY));
		fx_set_parameter(DistortionEffect, "g_Bound" + string(i + 1), Bound);
	}
}