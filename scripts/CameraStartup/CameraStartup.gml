function CameraStartup() 
{
	if instance_exists(Player)
	{
		// Mark player as a target object
		Target = Player;
		
		// If player uses saved global spawn position, spawn camera on it
		if !array_equals(Game.PlayerPosition, [])
		{
			PosX = Game.PlayerPosition[0] - Game.Width  / 2;
			PosY = Game.PlayerPosition[1] - Game.Height / 2 + 16;
		}
	}
	
	// Enable camera movement
	Enabled = true;
}