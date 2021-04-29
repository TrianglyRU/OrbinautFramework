function ScreenCameraPositionUpdate() 
{	
	// Define final camera positions
	RenderX = floor(CameraX + ExtendedOffset);
	RenderY = floor(CameraY - SpinOffset + OverviewOffset + ShakeOffset);
	
	// Keep the camera inside its limits
	RenderX = clamp(RenderX, MinRenderX, MaxRenderX - Width);
	RenderY = clamp(RenderY, MinRenderY, MaxRenderY - Height);
	
	// Display camera on calculated positions
	camera_set_view_pos(view_camera[0], RenderX, RenderY)
}