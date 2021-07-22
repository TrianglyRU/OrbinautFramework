function StageActStartup()
{
	// Play stage music
	audio_bgm_play(StageMusic, StageMusicLooppoint, TypeNormal);
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionTilesA"), layer_tilemap_get_id("CollisionTilesB")];
	
	// Set bubble wobble data if water is enabled
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
	
	// Load saved time and stage boundary (loading on checkpoint)
	if Game.Time
	{
		Time = Game.Time;
	}
	if Game.StageBoundary
	{
		BottomBoundary = Game.StageBoundary;
	}
	
	// Set boundaries
	TargetLeftBoundary   = LeftBoundary;
	TargetRightBoundary  = RightBoundary;
	TargetTopBoundary    = TopBoundary;
	TargetBottomBoundary = BottomBoundary;
	DeathBoundary        = BottomBoundary;
}