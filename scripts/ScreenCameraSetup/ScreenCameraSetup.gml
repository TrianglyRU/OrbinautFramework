function ScreenCameraSetup() 
{
	// Enable camera movement
	CameraEnabled = false;
	
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;

	// Set default position
	if Game.StageTransitions and Game.TransitionShiftCamera != 0
	{
		RawX    = floor(Player.PosX) - Game.TransitionShiftPlayer[0] - Screen.Width / 2;
		RawY    = floor(Player.PosY) - Game.TransitionShiftCamera;
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
	
	// Set maximum and minimum limits
	MinRenderX = Stage.LeftBoundary;
	MinRenderY = Stage.TopBoundary;
	MaxRenderX = Stage.RightBoundary;
	MaxRenderY = Stage.BottomBoundary;
	
	GameSurf = -1;
	BGSurf   = -1;
}