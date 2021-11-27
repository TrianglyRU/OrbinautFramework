function CameraStartup() 
{
	// Enable camera
	Enabled	= true;
	
	// Set maximum possible speed
	MaxShiftX = 16;
	MaxShiftY = 16;
	
	// Set blank values
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
	
	// Set player as a default target
	Target = Player;
	
	// Set start position on Star Post or Special Ring if corresponding data exist
	if instance_exists(Stage)
	{
		if array_length(Game.StarPostData)
		{
			PosX = Game.StarPostData[0] - Game.Width  / 2;
			PosY = Game.StarPostData[1] - Game.Height / 2 + 16;
		}
		if array_length(Game.SpecialRingData)
		{
			PosX = Game.SpecialRingData[0] - Game.Width  / 2;
			PosY = Game.SpecialRingData[1] - Game.Height / 2 + 16;
		}
		
		/* If none of the positions above exist, camera's start position will be set
		on spawnpoint. It is handled from its side! */
	}
	
	// Enable room viewport 0 and make it visible
	view_enabled[0] = true;
	view_visible[0] = true;	
	
	// Adjust surfaces and camera view to game resolution	
	application_set_size(Game.Width, Game.Height);
}