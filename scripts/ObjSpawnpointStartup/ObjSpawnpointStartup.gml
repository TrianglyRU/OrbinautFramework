function ObjSpawnPointSetup()
{
	instance_destroy();
	
	// Spawn player on the object if they should use it
	if !Player.PosX and !Player.PosY
	{
		switch PlayerType
		{
			case "Sonic & Tails":
				if (global.Character == CharKnuckles) return;
			break;
			case "Knuckles":
				if (global.Character != CharKnuckles) return;
			break;
		}
		
		Player.PosX = x;
		Player.PosY = y - Player.RadiusY - 1;
		
		Camera.PosX = Player.PosX - global.Width  / 2;
		Camera.PosY = Player.PosY - global.Height / 2 + 16;
	}
}