/// @function distortion_set(distData1,distData2,distScale1,distScale2,layers,boundType)
function distortion_set(distData1,distData2,distScale1,distScale2,layers,boundType)
{
	
	var Data1 = sprite_get_texture(distData1, 0);
	var Data2 = sprite_get_texture(distData2, 0);
	
	DistortionEffect = fx_create("_filter_waves");
	
	DistortionBound  = boundType;
	
	// Set parameters
	fx_set_parameter(DistortionEffect, "g_WaveData1",  distData1);
	fx_set_parameter(DistortionEffect, "g_WaveData2",  distData2);
	fx_set_parameter(DistortionEffect, "g_ScreenWid",  global.Width + global.ScreenBuffer * 2);
	
	var Width  = sprite_get_width(distData1);
	var Height = sprite_get_height(distData1);
	var TexW   = texture_get_texel_width(Data1);
	var TexH   = texture_get_texel_height(Data1);
	var Len    = Width * Height;
	
	fx_set_parameter(DistortionEffect, "g_DataValues1", distScale1, Len);
	fx_set_parameter(DistortionEffect, "g_DataParams1", Width, Height, TexW, TexH);
	
	Width  = sprite_get_width(distData2);
	Height = sprite_get_height(distData2);
	TexW   = texture_get_texel_width(Data2);
	TexH   = texture_get_texel_height(Data2);
	Len    = Width * Height;	
	
	fx_set_parameter(DistortionEffect, "g_DataValues2", distScale2, Len);
	fx_set_parameter(DistortionEffect, "g_DataParams2", Width, Height, TexW, TexH);
	
	fx_set_single_layer(DistortionEffect, true);

	// Apply the effect to our layers
	var Length = array_length(layers);
	for (var i = 0; i < Length; i++)
	{
		layer_set_fx(layers[i],	DistortionEffect);
	}
}