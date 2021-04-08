function ScreenCameraSetup() 
{
	// Disable camera movement
	CameraEnabled = false;
	
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;

	// Set default position
	if Game.StageTransition and Game.StageTransferX != 0 and Game.StageTransferY != 0
	{
		ViewX = floor(Player.PosX) - Game.StageTransferX;
		ViewY = floor(Player.PosY) - Game.StageTransferY;
	}
	else
	{
		ViewX = floor(Player.PosX) - Width  / 2;
		ViewY = floor(Player.PosY) - Height / 2 + 12;
	}
}