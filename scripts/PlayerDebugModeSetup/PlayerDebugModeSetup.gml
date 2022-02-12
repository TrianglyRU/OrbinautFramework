function PlayerDebugModeSetup()
{
	if !global.DevMode
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