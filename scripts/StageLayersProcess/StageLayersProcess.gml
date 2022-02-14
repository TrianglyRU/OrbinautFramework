function StageLayersProcess()
{
	fx_set_parameter(FxWaves, "g_Time", Time);
	
	if WaterEnabled
	{
		var Boundary = global.Height - clamp(Camera.ViewY - WaterLevel + global.Height, 0, global.Height);
	}
	else
	{
		var Boundary = global.Height;
	}
	
	fx_set_parameter(FxWaves, "g_Bound", Boundary);
}