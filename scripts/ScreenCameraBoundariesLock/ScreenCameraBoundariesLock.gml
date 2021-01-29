function ScreenCameraBoundariesLock() 
{	
	ViewX = clamp(ViewX, Stage.LeftBoundary, Stage.RightBoundary - Width);
	ViewY = clamp(ViewY, Stage.TopBoundary, Stage.BottomBoundary - Height);
}