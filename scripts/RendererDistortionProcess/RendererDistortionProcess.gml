function RendererDistortionProcess()
{		
	if DistortionEffect == noone
	{
		return;
	}
	
	// Count time (basically, it is the speed of the distortion effect)
	if !DistortionMode1 and Stage.UpdateObjects
	or  DistortionMode1 and Renderer.UpdateAnimations
	{
		DistortionTimer += 0.5;
	}
	
	// Set a distortion boundary (water level for a playable stage, entire screen otherwise)
	switch DistortionMode1
	{
		case 0:
			var Bound = global.Height - clamp(Camera.ViewY - Stage.WaterLevel + global.Height, 0, global.Height);
		break;
		case 1:
			var Bound = room_height;
		break;
		case 2:
			var Bound = 0;
		break;
	}
	fx_set_parameter(DistortionEffect, "g_WaveY1", floor(DistortionTimer + Camera.ViewY));
	fx_set_parameter(DistortionEffect, "g_Bound1", Bound);
	
	switch DistortionMode2
	{
		case 0:
			var Bound = global.Height - clamp(Camera.ViewY - Stage.WaterLevel + global.Height, 0, global.Height);
		break;
		case 1:
			var Bound = room_height;
		break;
		case 2:
			var Bound = 0;
		break;
	}
	
	fx_set_parameter(DistortionEffect, "g_WaveY2", floor(DistortionTimer + Camera.ViewY));
	fx_set_parameter(DistortionEffect, "g_Bound2", Bound);
}