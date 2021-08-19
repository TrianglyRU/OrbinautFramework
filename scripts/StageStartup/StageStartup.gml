function StageStartup()
{
	// Play stage music
	audio_bgm_play(PriorityLow, StageMusic, other);
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionLayerA"), layer_tilemap_get_id("CollisionLayerB")];
	
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
	
	// Load player and camera on global spawn position in case it exists
	if !array_equals(Game.PlayerPosition, [])
	{
		Player.PosX = Game.PlayerPosition[0];
		Player.PosY = Game.PlayerPosition[1];
		Camera.PosX = Game.PlayerPosition[0] - Game.Width  / 2;
		Camera.PosY = Game.PlayerPosition[1] - Game.Height / 2 + 16;
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