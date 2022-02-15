/// @function distortion_set(slot,distData,distScale,layers,boundType)
function distortion_set(slot,distData,distScale,layers,boundType)
{
	DistortionEffect[slot] = fx_create("_filter_waves");
	DistortionBound[slot]  = boundType;
	
	// Set parameters
	fx_set_parameter(DistortionEffect[slot], "g_WaveData",  distData);
	fx_set_parameter(DistortionEffect[slot], "g_DataLen",   distScale);
	fx_set_parameter(DistortionEffect[slot], "g_DataSize",  array_length(distData));
	fx_set_parameter(DistortionEffect[slot], "g_ScreenWid", global.Width);
	
	fx_set_single_layer(DistortionEffect[slot], true);
	
	// Apply the effect to our layers
	var Length = array_length(layers);
	for (var i = 0; i < Length; i++)
	{
		layer_set_fx(layers[i],	DistortionEffect[slot]);
	}
}