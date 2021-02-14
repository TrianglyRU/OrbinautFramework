function ScreenCameraSetup() 
{	
	CameraEnabled = true;
	
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;
	
	// Set default position
	ViewX = Player.PosX - Width  / 2;
	ViewY = Player.PosY - Height / 2;
}