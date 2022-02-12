function CameraStartup() 
{
	Target		   = Player;
	Enabled		   = true;
	MaxShiftX	   = 16;
	MaxShiftY	   = 16;
	TargetX	       = 0;
	TargetY	       = 0;
	PosX	       = 0;
	PosY	       = 0;
	ViewX	       = 0;
	ViewY	       = 0;
	ShiftX	       = 0;
	ShiftY	       = 0;
	ScrollDelay    = 0;
	OverviewDelay  = 0;
	ExtendedOffset = 0;
	OverviewOffset = 0;
	ShakeTime      = 0;
	ShakeX	       = 0;
	ShakeY	       = 0;
	
	// Set start position to Star Post or Special Ring
	if instance_exists(Stage)
	{
		if array_length(global.StarPostData)
		{
			PosX = global.StarPostData[0] - global.Width  / 2;
			PosY = global.StarPostData[1] - global.Height / 2 + 16;
		}
		if array_length(global.SpecialRingData)
		{
			PosX = global.SpecialRingData[0] - global.Width  / 2;
			PosY = global.SpecialRingData[1] - global.Height / 2 + 16;
		}
	}
	
	// Enable room viewport 0 and make it visible
	view_enabled[0] = true;
	view_visible[0] = true;	
	
	// Adjust surfaces and camera view to game resolution	
	application_set_size(global.Width, global.Height);
}