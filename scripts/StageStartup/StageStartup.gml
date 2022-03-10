function StageStartup()
{
	// Initialise variables
	RightBoundary  =  room_width;
	LeftBoundary   =  0;
	TopBoundary	   =  0;
	RestartTimer   =  0;
	RestartEvent   =  0;
	IsFinished	   =  0;
	IsPaused	   =  0;
	Time		   =  0;
	TimeEnabled	   =  0;
	IsBossfight    = -1;
	OscillateAngle =  1.40625;
	UpdateObjects  =  false;
	
	// Remember current room index
	global.StageRoom = room;
	
	// Set bubble wobble data
	if WaterEnabled
	{
		WobbleData =
		[ 
		  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
		  2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
		  3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2,
		  2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
		  0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3,
		 -3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,
		 -4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,
		 -3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1
		]
	}
	
	// Load saved data if loading into the stage from Bonus or Special Stage
	if array_length(global.StarPostData)
	{
		Time		   = global.StarPostData[2];
		BottomBoundary = global.StarPostData[3];
	}
	if array_length(global.SpecialRingData)
	{
		Time		   = global.SpecialRingData[4];
		BottomBoundary = global.SpecialRingData[5];
		
		// Clear data (player has already restored their rings and barrier atm.)
		global.SpecialRingData = [];
	}
	
	// Set stage boundaries
	TargetLeftBoundary   = LeftBoundary;
	TargetRightBoundary  = RightBoundary;
	TargetTopBoundary    = TopBoundary;
	TargetBottomBoundary = BottomBoundary;
	DeathBoundary        = BottomBoundary;
	
	// Play stage music
	audio_bgm_play(AudioPrimary, StageMusic);
}