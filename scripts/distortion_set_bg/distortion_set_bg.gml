/// @function distortion_set_bg(data1,data2,speed,[datarange])
function distortion_set_bg(data1,data2,speed,datarange)
{
	try
	{
		// Set mode
		if instance_exists(Stage)
		{
			DistortionMode[1] = "Stage";
		}
		else
		{
			DistortionMode[1] = "Screen";
		}
		DistortionEffect[1] = fx_create("_filter_waves");
		
		// Load effects
		var Data = [data1, data2];
		
		for (var i = 0; i < 2; i++)
		{
			if Data[i] != noone and (i == 0 or DistortionMode[1] == "Stage")
			{	
				var UVs		= sprite_get_uvs(Data[i], 0);
				var Texture = sprite_get_texture(Data[i], 0);
				var TexelX	= texture_get_texel_width(Texture);
				var TexelY  = texture_get_texel_height(Texture);
			
				fx_set_parameter(DistortionEffect[1], "g_WaveData"   + string(i + 1), Data[i]);
				fx_set_parameter(DistortionEffect[1], "g_DataParams" + string(i + 1), UVs[0] + TexelX / 2, UVs[1] + TexelY / 2, TexelY);
				
				DistortionLoaded[1][i] = true;			
			}
		}
		
		DistortionRangeBG  = is_array(datarange) ? datarange : [noone, noone];
		DistortionSpeed[1] = speed;
		
		fx_set_parameter(DistortionEffect[1], "g_Bound1", 0);
		fx_set_parameter(DistortionEffect[1], "g_Bound4", room_height);
		fx_set_parameter(DistortionEffect[1], "g_ScreenWid",  global.Width + global.ScreenBuffer * 2);
		
		fx_set_single_layer(DistortionEffect[1], true);
		
		// Apply the effect to our background layer
		layer_set_fx(string(layer_get_name(Background.layer)), DistortionEffect[1]);
	}
	catch (Exception)
	{
		show_debug_message("\n"
							+ "============================================= \n"
							+ Exception.script + " function didn't proceed,  \n"
							+ "an error has occured! \n"
							+ "\n"
							+ "If you don't have the effect, please, install it from the Release Package you downloaded. \n"
							+ "You may also get this message because you configured the distortion incorrectly. \n"
							+ "=============================================");
		DistortionEffect[1] = noone;
	}
}