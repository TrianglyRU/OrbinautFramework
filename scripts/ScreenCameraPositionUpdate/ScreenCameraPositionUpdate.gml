function ScreenCameraPositionUpdate() 
{	
	// Define final camera positions
	CameraX = floor(RawX + ExtendedOffset);
	CameraY = floor(RawY - SpinOffset + OverviewOffset + ShakeOffset);
	
	// Keep the camera inside its limits
	CameraX = clamp(CameraX, MinRenderX, MaxRenderX - Width);
	CameraY = clamp(CameraY, MinRenderY, MaxRenderY - Height);
	
	// Display camera on calculated positions
	camera_set_view_pos(view_camera[0], CameraX, CameraY)
}