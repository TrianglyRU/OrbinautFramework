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
		SpringVertical,
		SpringHorizontal,
		StarPost,
		FloatingPlatform,
		Bridge,
		Animal	
	]
}