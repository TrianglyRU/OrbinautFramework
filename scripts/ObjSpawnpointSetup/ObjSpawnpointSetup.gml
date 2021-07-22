function ObjSpawnpointSetup()
{
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Check if player should use spawnpoint to spawn
	if Game.PlayerPosition == 0
	{
		// Check which spawnpoint player should use
		if id.PlayerType == "Sonic & Tails" and Player.CharacterID == CharKnuckles
		or id.PlayerType == "Knuckles"		and Player.CharacterID != CharKnuckles
		{
			exit;
		}
		
		// Set player position on spawnpoint
		Player.PosX = x;
		Player.PosY = y - Player.yRadius;
			
		// Set camera
		Screen.RawX    = floor(Player.PosX) - Screen.Width  / 2;
		Screen.RawY    = floor(Player.PosY) - Screen.Height / 2 + 16;
		Screen.CameraX = Screen.RawX;
		Screen.CameraY = Screen.RawY;
	}

	// Remove self
	instance_destroy();
}