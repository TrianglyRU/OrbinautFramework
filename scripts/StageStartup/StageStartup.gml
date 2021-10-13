function StageStartup()
{
	// Set blank values
	EventTimer	= 0;
	IsFinished	= 0;
	IsPaused	= 0;
	IsGameOver	= 0;
	Time		= 0;
	TimeEnabled	= 0;
	DoUpdate	= 0;
	
	// Play stage music
	audio_bgm_play(PriorityLow, StageMusic, other, other);
	
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
	
	// If player has respawned on checkpoint, load saved stage data
	if array_length(Game.StarPostData)
	{
		Time		   = Game.StarPostData[2];
		BottomBoundary = Game.StarPostData[3];
	}
	
	// If coming from special stage, load saved stage data
	if array_length(Game.SpecialRingData)
	{
		Time		   = Game.SpecialRingData[4];
		BottomBoundary = Game.SpecialRingData[5];
	}
	
	// Store current zone ID and room index
	Game.Stage     = ZoneID;
	Game.StageRoom = room;
	
	// Set stage boundaries
	TargetLeftBoundary   = LeftBoundary;
	TargetRightBoundary  = RightBoundary;
	TargetTopBoundary    = TopBoundary;
	TargetBottomBoundary = BottomBoundary;
	DeathBoundary        = BottomBoundary;
	
	// Set bossfight status
	IsBossfight = -1;
}