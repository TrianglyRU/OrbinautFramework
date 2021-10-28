function PlayerDebugModeSetup()
{
	// Exit the code if dev mode is disabled
	if !Game.DevMode
	{
		exit;
	}

	// Define debug objects list
	DebugList = 
	[
		Ring,
		SpecialRing,
		ItemBox,
		SpikesVertical,
		SpikesHorizontal,
		SpringYellowVertical,
		SpringYellowHorizontal,
		SpringYellowDiagonal,
		SpringRedVertical,
		SpringRedHorizontal,
		SpringRedDiagonal,
		SpringRamp,
		StarPost,
		Animal,
		ClearPlate,
		EggPrison,
	];
}