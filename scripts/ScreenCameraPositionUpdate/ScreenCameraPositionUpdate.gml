function ScreenCameraPositionUpdate() 
{	
	// Exit if paused
	if Stage.GamePaused
	{
		exit;
	}
	
	// Define final camera positions
	CameraX = floor(RawX + ExtendedOffset);
	CameraY = floor(RawY - SpinOffset + OverviewOffset + ShakeOffset);
	
	// Keep the camera inside its limits
	CameraX = clamp(CameraX, Stage.LeftBoundary, Stage.RightBoundary  - Width);
	CameraY = clamp(CameraY, Stage.TopBoundary,  Stage.BottomBoundary - Height);
	
	// Display camera on calculated positions
	camera_set_view_pos(view_camera[0], CameraX - 8, CameraY)
}