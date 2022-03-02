/// @function distortion_set(data1,data2,layerArray)
function distortion_set(data1,data2,layerArray)
{	
	try
	{
		// Set mode
		if instance_exists(Stage)
		{
			DistortionMode[0] = 0;
		}
		else
		{
			DistortionMode[0] = 1;
		}
		DistortionEffect[0] = fx_create("_filter_waves");
		
		// Load effects
		var Data = [data1, data2];
		
		for (var i = 0; i < 2; i++)
		{
			if Data[i] != noone and (i == 0 or !DistortionMode[0])
			{	
				var UVs		= sprite_get_uvs(Data[i], 0);
				var Texture = sprite_get_texture(Data[i], 0);
				var TexelX	= texture_get_texel_width(Texture);
				var TexelY  = texture_get_texel_height(Texture);
			
				fx_set_parameter(DistortionEffect[0], "g_WaveData"   + string(i + 1), Data[i]);
				fx_set_parameter(DistortionEffect[0], "g_DataParams" + string(i + 1), UVs[0] + TexelX / 2, UVs[1] + TexelY / 2, TexelY);
			
				DistortionEnabled[0][i] = true;
			}
		}

		fx_set_parameter(DistortionEffect[0], "g_ScreenWid",  global.Width + global.ScreenBuffer * 2);
		fx_set_single_layer(DistortionEffect[0], true);
		
		// Apply the effect to our layers
		var Len = array_length(layerArray);
		for (var i = 0; i < Len; i++)
		{
			layer_set_fx(layerArray[i],	DistortionEffect[0]);
		}
	}
	catch (Exception)
	{
		show_debug_message("\n"
							+ "============================================= \n"
							+ "distortion_set() function didn't proceed, \n"
							+ "an error has occured! \n"
							+ "\n"
							+ "If you don't have the effect, please, install it from the Release Package you downloaded. \n"
							+ "You may also get this message because you set up the distortion incorrectly. \n"
							+ "=============================================");
		DistortionMode[0]    = noone;
		DistortionEffect[0]  = noone;
		DistortionEnabled[0] = [false, false];
	}
}