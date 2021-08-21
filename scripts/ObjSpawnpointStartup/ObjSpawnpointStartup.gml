function ObjSpawnpointSetup()
{
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Check if player should use spawnpoint to spawn
	if array_equals(Game.PlayerPosition, [])
	{
		// Check which spawnpoint player should use
		if id.PlayerType == "Sonic & Tails" and Game.Character == CharKnuckles
		or id.PlayerType == "Knuckles"		and Game.Character != CharKnuckles
		{
			exit;
		}
		
		// Set player position on spawnpoint
		Player.PosX = x;
		Player.PosY = y - Player.RadiusY - 1;
			
		// Set camera
		Camera.PosX = floor(Player.PosX) - Game.Width  / 2;
		Camera.PosY = floor(Player.PosY) - Game.Height / 2 + 16;
	}

	// Remove self
	instance_destroy();
}