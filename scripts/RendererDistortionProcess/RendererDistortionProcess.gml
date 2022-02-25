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
	
	// Set a distortion boundary (water level for a playable stage, entire screen otherwise)
	if !DistortionMode
	{
		var Bound = global.Height - clamp(Camera.ViewY - Stage.WaterLevel + global.Height, 0, global.Height);
	}
	else
	{
		var Bound = 0;
	}
	
	fx_set_parameter(DistortionEffect, "g_Time",  floor(DistortionTimer + Camera.ViewY));
	fx_set_parameter(DistortionEffect, "g_Bound", Bound);
}