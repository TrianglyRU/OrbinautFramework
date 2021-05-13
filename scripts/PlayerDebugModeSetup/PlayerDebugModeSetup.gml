function PlayerDebugModeSetup()
{
	// Exit the code if dev mode is disabled
	if (!Game.DevMode) exit;

	// Set debug flags
	DebugMode  = false;
	DebugItem  = 0;
	DebugSpeed = 0;
	
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