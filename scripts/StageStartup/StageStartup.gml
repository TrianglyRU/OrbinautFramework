function StageStartup()
{
	// Play stage music
	audio_bgm_play(PriorityLow, StageMusic, other);
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionLayerA"), layer_tilemap_get_id("CollisionLayerB")];
	
	/* Once again, we don't do this normally, but we call it here
	to prevent all object being active for 1 frame when stage loads */
	StageObjectsInactiveProcess();
	
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
	
	// Load saved time and stage boundary
	if Game.Time
	{
		Time = Game.Time;
	}
	if Game.StageBoundary
	{
		BottomBoundary = Game.StageBoundary;
	}
	
	// Grant maximum emeralds if in devmode
	if Game.DevMode
	{
		Game.Emeralds = 7;
	}
	
	// Store current zone and room ID
	Game.CurrentStage = [ZoneID, room];
	
	// Set stage boundaries
	TargetLeftBoundary   = LeftBoundary;
	TargetRightBoundary  = RightBoundary;
	TargetTopBoundary    = TopBoundary;
	TargetBottomBoundary = BottomBoundary;
	DeathBoundary        = BottomBoundary;
	
	// Set boss status
	IsBossfight = -1;
}