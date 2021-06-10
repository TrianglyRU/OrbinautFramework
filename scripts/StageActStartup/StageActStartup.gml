function StageActStartup()
{
	// Play stage music
	audio_bgm_play(StageMusic, StageMusicDAC, StageMusicLooppoint, TypeNormal);
	
	// Set target boundaries
	TargetLeftBoundary   = LeftBoundary;
	TargetRightBoundary  = RightBoundary;
	TargetTopBoundary    = TopBoundary;
	TargetBottomBoundary = BottomBoundary;
	DeathBoundary        = BottomBoundary;

	// Load tile angle data
	data_read("anglemap.bin");
	
	// Load tile height data
	data_read("heightmap.bin");
	
	// Load tile width data
	data_read("widthmap.bin");
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionTilesA"), layer_tilemap_get_id("CollisionTilesB")];
}