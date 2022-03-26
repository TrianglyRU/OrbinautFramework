/// @description Process Distortion / Create Surfaces
// You can write your code in this editor
	
	#region Process Distortion
	{
		var Height = global.Height;
	
		// Loop through FG and BG distortion effects
		for (var i = 0; i < 2; i++)
		{
			if DistortionEffect[i] != noone
			{
				if DistortionMode[i] == "Stage"  and Stage.UpdateObjects
				or DistortionMode[i] == "Screen" and Renderer.UpdateAnimations
				{
					// Update distortion
					DistortionShift[i][0] += DistortionSpeed[i];
					DistortionShift[i][1] += DistortionSpeed[i];
				}
			
				var Range = i ? DistortionRangeBG : DistortionRangeFG;
			
				// Loop through surface and underwater distortion
				for (var j = 0; j < 2; j++)
				{
					// Set a boundary between surface and underwater distortion
					if DistortionLoaded[i][j]
					{
						if DistortionMode[i] == "Stage"
						{
							var SplitBound = Height - clamp(floor(Camera.ViewY - Stage.WaterLevel + Height), 0, Height);
						}
						else
						{
							var SplitBound = j ? 0 : room_height;
						}
					}
					else
					{
						var SplitBound = j ? room_height : 0;
					}
				
					// Apply it
					fx_set_parameter(DistortionEffect[i], "g_Bound" + string(j + 2), SplitBound);
				
					if j == 0
					{
						var Bound = Range[0] != noone ? max(SplitBound - Range[0], 0) : 0;
						fx_set_parameter(DistortionEffect[i], "g_Bound1", Bound);
					}
					else
					{
						var Bound = Range[1] != noone ? min(SplitBound + Range[1], Height) : Height;
						fx_set_parameter(DistortionEffect[i], "g_Bound4", Bound);
					}
				
					// Set position
					if i == 1 and array_length(Background.BGSprites)
					{
						fx_set_parameter(DistortionEffect[i], "g_WaveY" + string(j + 1), floor(DistortionShift[i][j] + Camera.ViewY * Background.BGValues[0][4]));
					}
					else
					{
						fx_set_parameter(DistortionEffect[i], "g_WaveY" + string(j + 1), floor(DistortionShift[i][j] + Camera.ViewY));
					}
				}
			}
		}
	}
	#endregion
	
	#region Create Surfaces
	{
	    if !surface_exists(SurfaceLow)
	    {
	        SurfaceLow = surface_create(global.Width + global.ScreenBuffer * 2, global.Height);
        
	        surface_set_target(SurfaceLow);
	        draw_clear_alpha(c_black, 0);
	        surface_reset_target();
        
	        view_surface_id[0] = SurfaceLow;
	    }
	    if !surface_exists(SurfaceHigh)
	    {
	        SurfaceHigh = surface_create(global.Width, global.Height);
        
	        surface_set_target(SurfaceHigh);
	        draw_clear_alpha(c_black, 0);
	        surface_reset_target();
	    }
	}
	#endregion
	
	// Call main shader
	shader_set(ShaderMain);