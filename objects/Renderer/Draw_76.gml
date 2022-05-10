/// @description Init. Surfaces & Process Effects
// You can write your code in this editor
	
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
				var BGExists = array_length(Background.BGSprites);
				
                var Range		= i ? DistortionRangeBG : DistortionRangeFG;
                var DistortionY = i and BGExists ? ceil(Camera.ViewY * Background.BGValues[0][4]) : Camera.ViewY;
 
                // Set a boundary between surface and underwater distortion
                if DistortionMode[i] == "Stage"
                {
                    var SplitBound = Height - clamp(floor(Camera.ViewY - Stage.WaterLevel + Height), 0, Height);
                }
                else
                {
                    var SplitBound = room_height;
                }
                
                // Apply it
                fx_set_parameter(DistortionEffect[i], "g_Bound2", SplitBound);
            
                // Loop through surface and underwater distortion
                for (var j = 0; j < 2; j++)
                {
                    if DistortionLoaded[i][j]
                    {
                        var Bound = Range[j] != noone ? clamp(Range[j] - DistortionY, 0, Height) : (j ? Height : 0);
                        fx_set_parameter(DistortionEffect[i], "g_Bound" + (j ? "3" : "1"), Bound);
                    }
                    else
                    {
						fx_set_parameter(DistortionEffect[i], "g_Bound" + (j ? "3" : "1"), SplitBound);
                    }
                    
                    fx_set_parameter(DistortionEffect[i], "g_WaveY" + (j ? "2" : "1"), floor(DistortionShift[i][j] + DistortionY));
                }
            }
        }
    }
    #endregion
	
	// Call main shader
	shader_set(ShaderMain);