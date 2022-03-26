/// @description Startup / Setup
// You can write your code in this editor
	
	#region Animation Startup
	{
		UpdateAnimations = false;
	
		AnimationTime = ds_map_create();
		AnimationTime[? GlobalTime] = 0;
	}
	#endregion
	
	#region Surface Startup
	{
		SurfaceLow	 = noone;
		SurfaceHigh	 = noone;
		SurfaceReset = false;
	}
	#endregion
	
	#region Distortion Startup
	{
		DistortionMode	  =  ["", ""];
		DistortionEffect  =  [noone, noone];
		DistortionRangeBG =  [noone, noone];
		DistortionRangeFG =  [noone, noone];
		DistortionSpeed   =  [0, 0];
		DistortionShift   = [[0, 0], [0, 0]];
		DistortionLoaded  = [[false, false], [false, false]];
	}
	#endregion
	
	#region Distortion Setup
	{
		/* Please note that if there is no Stage controller in the room,
		the game will only use a distortion effect assigned to data1 */
	
		switch room
		{
			case Stage_TSZ:
			{
				distortion_set(noone, dist_water, 0.5, noone, ["GraphicsA", "AnimatedTiles", "GraphicsB"]);
				distortion_set_bg(dist_heat, dist_water_bg, 0.5, noone);
			}
			break;
		}
	}
	#endregion