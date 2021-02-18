function ScreenCameraSetup() 
{
	// Set width and height values
	Width  = Game.ResolutionWidth;
	Height = Game.ResolutionHeight;
	
	// Set default position
	ViewX = floor(Player.PosX) - Width  / 2;
	ViewY = floor(Player.PosY) - Height / 2 + 12;
}