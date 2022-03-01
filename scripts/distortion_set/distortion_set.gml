/// @function distortion_set(isbg,data1,data2,layerArray)
function distortion_set(isbg,data1,data2,layerArray)
{	
	try
	{
		var data = [data1, data2];
		
		// Set mode
		if instance_exists(Stage)
		{
			DistortionMode[isbg] = 0;
		}
		else
		{
			DistortionMode[isbg] = 1;
		}
		DistortionEffect[isbg] = fx_create("_filter_waves");
		
		// Load effects
		for (var i = 0; i < 2; i++)
		{
			if data[i] != noone and (!i or !DistortionMode[isbg])
			{	
				var UVs		= sprite_get_uvs(data[i], 0);
				var Texture = sprite_get_texture(data[i], 0);
				var TexelX	= texture_get_texel_width(Texture);
				var TexelY  = texture_get_texel_height(Texture);
			
				fx_set_parameter(DistortionEffect[isbg], "g_WaveData"   + string(i + 1), data[i]);
				fx_set_parameter(DistortionEffect[isbg], "g_DataParams" + string(i + 1), UVs[0] + TexelX / 2, UVs[1] + TexelY / 2, TexelY);
			
				DistortionEnabled[isbg][i] = true;
			}
		}

		// Set additional parameters
		fx_set_parameter(DistortionEffect[isbg], "g_ScreenWid",  global.Width + global.ScreenBuffer * 2);
		fx_set_single_layer(DistortionEffect[isbg], true);
		
		// Apply the effect to our layers
		var Len = array_length(layerArray);
		for (var i = 0; i < Len; i++)
		{
			layer_set_fx(layerArray[i],	DistortionEffect[isbg]);
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
		DistortionEffect[isbg]  = noone;
		DistortionMode[isbg]    = noone;
		DistortionEnabled[isbg] = [false, false];
	}
}