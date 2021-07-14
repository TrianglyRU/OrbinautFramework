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
		ItemBox,
		SpikesVertical,
		SpringYellowVertical,
		SpringYellowHorizontal,
		SpringYellowDiagonal,
		SpringRedVertical,
		SpringRedHorizontal,
		SpringRedDiagonal,
		StarPost,
		FloatingPlatform,
		Bridge,
		Animal	
	]
}