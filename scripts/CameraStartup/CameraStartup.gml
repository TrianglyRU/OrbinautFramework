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
	
	// Load camera on global spawn position in case it exists
	if Target == Player and !array_equals(Game.PlayerPosition, [])
	{
		PosX = Game.PlayerPosition[0] - Game.Width  / 2;
		PosY = Game.PlayerPosition[1] - Game.Height / 2 + 16;
	}
}