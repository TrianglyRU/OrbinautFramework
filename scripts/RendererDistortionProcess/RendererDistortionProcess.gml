function RendererDistortionProcess()
{		
	if DistortionEffect == noone
	{
		exit;
	}
	
	// Count time (basically, it is the speed of distortion effect)
	static StageExists = instance_exists(Stage);
	if  StageExists and Stage.UpdateObjects
	or !StageExists and Renderer.UpdateAnimations
	{
		DistortionTimer += 0.5;
	}
	
	// Set speed
	fx_set_parameter(DistortionEffect, "g_Time", floor(DistortionTimer + Camera.ViewY));
		
	// Set a vertical limit of the distortion effect on our screen
	switch DistortionBound
	{
		case 0:
			var Bound = 0;
		break;
		case 1:
			var Bound = global.Height;
		break;
		case 2:
			var Bound = global.Height - clamp(Camera.ViewY - Stage.WaterLevel + global.Height, 0, global.Height);
		break;
	}
	fx_set_parameter(DistortionEffect, "g_Bound", Bound);
}