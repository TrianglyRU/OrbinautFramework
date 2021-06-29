function StageActStartup()
{
	// Play stage music
	audio_bgm_play(StageMusic, StageMusicDAC, StageMusicLooppoint, TypeNormal);
	
	// Set top, left and right boundaries
	TargetLeftBoundary  = LeftBoundary;
	TargetRightBoundary = RightBoundary;
	TargetTopBoundary   = TopBoundary;
	
	// Check if it is act transition
	if Game.StageTransitionData[4] == true
	{
		// Set target bottom boundary
		TargetBottomBoundary = BottomBoundary;
		DeathBoundary		 = TargetBottomBoundary;
	}
	
	// Check if it is not act transition
	else
	{
		// Load saved time and stage boundary (loading on checkpoint)
		if Game.Time
		{
			Time = Game.Time;
		}
		if Game.StageBoundary
		{
			BottomBoundary = Game.StageBoundary;
		}
		
		// Set target bottom boundary
		TargetBottomBoundary = BottomBoundary;
		DeathBoundary        = BottomBoundary;
	}
	
	// Load tile angle data
	data_read("anglemap.bin");
	
	// Load tile height data
	data_read("heightmap.bin");
	
	// Load tile width data
	data_read("widthmap.bin");
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionTilesA"), layer_tilemap_get_id("CollisionTilesB")];
}