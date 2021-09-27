function StageStartup()
{
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
	
	// Load saved time
	if array_length(Game.SpecialRingData)
	{
		Time = Game.SpecialRingData[2];
	}
	else if Game.Time
	{
		Time = Game.Time;
	}
	
	// Load saved stage boundary
	if Game.StageBoundary
	{
		BottomBoundary = Game.StageBoundary;
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
	
	// Hide collision layers
	layer_set_visible(Game.TileLayers[0], false);
	layer_set_visible(Game.TileLayers[1], false);
	
	/* We normally don't do this, but this is one of three cases where we call a script (not function) inside
	of another script. It is needed here to avoid objects being active for 1 frame upon stage loading */
	StageObjectsInactiveProcess();
}