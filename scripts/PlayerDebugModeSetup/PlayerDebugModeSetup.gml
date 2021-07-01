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
		SpikesVertical,
		SpringVertical,
		SpringHorizontal,
		Lamppost,
		FloatingPlatform,
		Bridge,
		Animal	
	]
}