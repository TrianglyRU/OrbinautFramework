/// @function distortion_set(data1,data2,layerArray)
function distortion_set(data1,data2,layerArray)
{	
	try
	{
		// Set mode
		if instance_exists(Stage)
		{
			DistortionMode = 0;
		}
		else
		{
			DistortionMode = 1;
		}
		DistortionEffect = fx_create("_filter_waves");
		
		// Load texture data
		var UVs		= sprite_get_uvs(data1, 0);
		var Texture = sprite_get_texture(data1, 0);
		var TexelX	= texture_get_texel_width(Texture);
		var TexelY  = texture_get_texel_height(Texture);
			
		fx_set_parameter(DistortionEffect, "g_WaveData1",   data1);
		fx_set_parameter(DistortionEffect, "g_DataParams1", UVs[0] + TexelX / 2, UVs[1] + TexelY / 2, TexelY);
		
		var UVs		= sprite_get_uvs(data2, 0);
		var Texture = sprite_get_texture(data2, 0);
		var TexelX	= texture_get_texel_width(Texture);
		var TexelY  = texture_get_texel_height(Texture);
			
		fx_set_parameter(DistortionEffect, "g_WaveData2",   data2);
		fx_set_parameter(DistortionEffect, "g_DataParams2", UVs[0] + TexelX / 2, UVs[1] + TexelY / 2, TexelY);

		// Set additional parameters
		fx_set_parameter(DistortionEffect, "g_ScreenWid",  global.Width + global.ScreenBuffer * 2);
		fx_set_single_layer(DistortionEffect, true);
		
		// Apply the effect to our layers
		for (var i = 0; i < array_length(layerArray); i++)
		{
			layer_set_fx(layerArray[i],	DistortionEffect);
		}
	}
	catch (Exception)
	{
		show_debug_message("\n"
						   + "============================================= \n"
						   + "distortion_set() function didn't proceed, you \n"
						   + "are missing the wave distortion effect! \n"
						   + "\n"
						   + "Please, install the effect from the Release Package you downloaded. \n"
						   + "You may also see this message because you setup the distortion data incorrectly. \n"
						   + "=============================================");
		DistortionEffect = noone;
		DistortionMode   = noone;
	}
}