/// @description Process Distortion / Create Surfaces
// You can write your code in this editor
	
	#region Process Distortion
	{
		var Height = global.Height;
		var Range  = DistortionBGRange;
	
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
			
				// Loop through surface and underwater distortion
				for (var j = 0; j < 2; j++)
				{
					// Set a boundary between surface and underwater distortion
					if DistortionLoaded[i][j]
					{
						if j == 1 and DistortionMode[i] == "Stage"
						{
							var SplitBound = Height - clamp(Camera.ViewY - Stage.WaterLevel + Height, 0, Height);
						}
						else
						{
							var SplitBound = room_height;
						}
					}
					else
					{
						var SplitBound = j ? room_height : 0;
					}
				
					// Apply it
					if !(i == 1 and j == 0 and Range[0] != noone)
					{
						fx_set_parameter(DistortionEffect[i], "g_Bound" + string(j + 2), SplitBound);
					}
				
					// Apply custom distortion boundaries for surface background
					else
					{
						var Position = Camera.ViewY - floor(Camera.ViewY * (1 - Background.BGValues[0][4])) + Height;
					
						var Bound1 = Height - clamp(Position - Range[0], 0, Height);
						var Bound2 = Height - clamp(Position - Range[1], 0, Height);
					
						fx_set_parameter(DistortionEffect[i], "g_Bound" + string(j + 1), Bound1);
						fx_set_parameter(DistortionEffect[i], "g_Bound" + string(j + 2), Bound2);
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