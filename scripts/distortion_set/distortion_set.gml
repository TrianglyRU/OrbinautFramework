/// @function distortion_set(distData1,distData2,layers,boundType)
function distortion_set(distData1,distData2,layers,boundType)
{	
	DistortionEffect = fx_create("_filter_waves");
	
	DistortionBound  = boundType;
	
	// Set parameters
	fx_set_parameter(DistortionEffect, "g_WaveData1",  distData1);
	fx_set_parameter(DistortionEffect, "g_WaveData2",  distData2);
	fx_set_parameter(DistortionEffect, "g_ScreenWid",  global.Width + global.ScreenBuffer * 2);
	
	var tex		= sprite_get_texture(distData1, 0);
	var UVs		= sprite_get_uvs(distData1, 0);
	var texel_x	= texture_get_texel_width(tex);
	var texel_y = texture_get_texel_height(tex);
	fx_set_parameter(DistortionEffect, "g_DataParams1", UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, texel_y);
	
	var tex		= sprite_get_texture(distData2, 0);
	var UVs		= sprite_get_uvs(distData2, 0);
	var texel_x	= texture_get_texel_width(tex);
	var texel_y = texture_get_texel_height(tex);
	fx_set_parameter(DistortionEffect, "g_DataParams2", UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, texel_y);
	
	fx_set_single_layer(DistortionEffect, true);

	// Apply the effect to our layers
	var Length = array_length(layers);
	for (var i = 0; i < Length; i++)
	{
		layer_set_fx(layers[i],	DistortionEffect);
	}
}