/// @function distortion_set(distData,distScale,layers,boundType)
function distortion_set(distData,distScale,layers,boundType)
{
	DistortionEffect = fx_create("_filter_waves");
	DistortionBound  = boundType;
	
	// Set parameters
	fx_set_parameter(DistortionEffect, "g_WaveData",  distData);
	fx_set_parameter(DistortionEffect, "g_DataLen",   distScale);
	fx_set_parameter(DistortionEffect, "g_DataSize",  array_length(distData));
	fx_set_parameter(DistortionEffect, "g_ScreenWid", global.Width);
	
	fx_set_single_layer(DistortionEffect, true);
	
	// Apply the effect to our layers
	var Length = array_length(layers);
	for (var i = 0; i < Length; i++)
	{
		layer_set_fx(layers[i],	DistortionEffect);
	}
}