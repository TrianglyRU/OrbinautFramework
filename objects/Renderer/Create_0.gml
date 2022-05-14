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
	
	// Setup Script
	DistortionSetup();
