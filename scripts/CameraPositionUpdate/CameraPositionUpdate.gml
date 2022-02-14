function CameraPositionUpdate()
{	
	// Calculate final view position
	if instance_exists(Stage)
	{
		ViewX = clamp(PosX + ExtendedOffset, Stage.LeftBoundary, Stage.RightBoundary  - global.Width);
		ViewY = clamp(PosY + OverviewOffset, Stage.TopBoundary,  Stage.BottomBoundary - global.Height);
	}
	else
	{
		ViewX = PosX;
		ViewY = PosY;
	}
	ViewX += ShakeX;
	ViewY += ShakeY;
	
	// Update camera position
	camera_set_view_pos(GameCamera, ViewX - global.ScreenBufer, ViewY);
}