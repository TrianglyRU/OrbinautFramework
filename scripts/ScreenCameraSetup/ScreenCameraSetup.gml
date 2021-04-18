function ScreenCameraSetup() 
{
	// Disable camera movement
	CameraEnabled = false;
	
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;

	// Set default position
	if Game.StageTransitions and Game.StageTransferX != 0 and Game.StageTransferY != 0
	{
		CameraX = floor(Player.PosX) - Game.StageTransferX;
		CameraY = floor(Player.PosY) - Game.StageTransferY;
	}
	else
	{
		CameraX = floor(Player.PosX) - Width  / 2;
		CameraY = floor(Player.PosY) - Height / 2 + 12;
	}
	
	// Set maximum and minimum limits
	MinRenderX = Stage.LeftBoundary;
	MinRenderY = Stage.TopBoundary;
	MaxRenderX = Stage.RightBoundary;
	MaxRenderY = Stage.BottomBoundary;
}