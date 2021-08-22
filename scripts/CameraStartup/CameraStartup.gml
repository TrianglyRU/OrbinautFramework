function CameraStartup() 
{
	// Setup room viewport 0
	view_enabled[0] = true;
	view_visible[0] = true;	
	
	// Adjust surfaces and camera view to game resolution	
	application_set_size(Game.Width, Game.Height);
	
	// Enable camera movement
	MaxShiftX = 16;
	MaxShiftY = 16;
	Enabled   = true;
	
	// Set player as a default target
	Target = Player;
	
	// If target is player, set camera position
	if Target == Player
	{
		// Set start position
		if !array_equals(Game.PlayerPosition, [])
		{
			PosX = Game.PlayerPosition[0] - Game.Width  / 2;
			PosY = Game.PlayerPosition[1] - Game.Height / 2 + 16;
		}
	
		// If coming from special stage, load on ring's position
		if !array_equals(Game.SpecialRingData, [])
		{
			PosX = Game.SpecialRingData[0] - Game.Width  / 2;
			PosY = Game.SpecialRingData[1] - Game.Height / 2 + 16;
		}
	
		/* If none of positions above exist, the camera will spawn
		on checkpoint. It is handled from its side! */
	}
}