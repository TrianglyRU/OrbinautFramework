function PlayerDebugModeSetup()
{
	if !Game.DevMode
	{
		return;
	}

	// Define debug objects list
	DebugList = 
	[
		Ring,
		SpecialRing,
		ItemBox,
		SpikesVertical,
		SpikesHorizontal,
		SpringRedVertical,
		SpringRedHorizontal,
		SpringRedDiagonal,
	];
}