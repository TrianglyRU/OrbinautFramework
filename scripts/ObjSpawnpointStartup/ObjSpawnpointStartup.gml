function ObjSpawnPointSetup()
{
	instance_destroy();
	
	// Check if player should use spawnpoint to spawn
	if !Player.PosX and !Player.PosY
	{
		switch PlayerType
		{
			case "Sonic & Tails":
				if (Game.Character == CharKnuckles) return;
			break;
			case "Knuckles":
				if (Game.Character != CharKnuckles) return;
			break;
		}
		
		Player.PosX = x;
		Player.PosY = y - Player.RadiusY - 1;
		
		Camera.PosX = Player.PosX - Game.Width  / 2;
		Camera.PosY = Player.PosY - Game.Height / 2 + 16;
	}
}