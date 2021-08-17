function ScreenCameraStartup() 
{
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;

	// If player uses saved global spawn position, spawn camera on it
	if !array_equals(Game.PlayerPosition, [])
	{
		RawX    = Game.PlayerPosition[0] - Width  / 2;
		RawY    = Game.PlayerPosition[1] - Height / 2 + 16;
		CameraX = RawX;
		CameraY = RawY
	}
	
	CameraEnabled = true;
}