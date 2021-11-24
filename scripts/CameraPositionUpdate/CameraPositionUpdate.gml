function CameraPositionUpdate()
{	
	// Calculate final view position
	if instance_exists(Stage)
	{
		ViewX = clamp(PosX + ExtendedOffset, Stage.LeftBoundary, Stage.RightBoundary  - Game.Width);
		ViewY = clamp(PosY + OverviewOffset, Stage.TopBoundary,  Stage.BottomBoundary - Game.Height);
	}
	else
	{
		ViewX = PosX;
		ViewY = PosY;
	}
	
	// Apply shake
	ViewX += ShakeX;
	ViewY += ShakeY;
	
	// Update camera position
	camera_set_view_pos(GameCamera, ViewX, ViewY);
}