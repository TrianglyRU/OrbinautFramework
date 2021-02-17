function ScreenCameraEndPosition()
{
	if Stage.State = ActStateFinished
	{
		TransitionX = floor(Player.PosX) - floor(ViewX);
		TransitionY = floor(Player.PosY) - floor(ViewY);
	}
}