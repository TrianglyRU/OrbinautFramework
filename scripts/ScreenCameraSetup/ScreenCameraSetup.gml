function ScreenCameraSetup() 
{	
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;
	
	// Set default position
	ViewX = Player.RealPosX - Width  / 2;
	ViewY = Player.RealPosY - Height / 2;
}