function ScreenCameraSetup() 
{
	// Enable camera movement
	CameraEnabled = false;
	
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;

	// Set default position
	if Game.StageTransitions and Game.StageTransitionData[2] != 0
	{
		RawX    = floor(Player.PosX) - Game.StageTransitionData[0] - Screen.Width / 2;
		RawY    = floor(Player.PosY) - Game.StageTransitionData[2];
		CameraX = RawX;
		CameraY = RawY;
	}
	else
	{
		RawX    = floor(Player.PosX) - Width  / 2;
		RawY    = floor(Player.PosY) - Height / 2 + 12;
		CameraX = RawX;
		CameraY = RawY;
	}
}