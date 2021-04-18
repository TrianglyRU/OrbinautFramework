function ScreenCameraPositionUpdate() 
{	
	// Define final camera positions
	RenderX = floor(CameraX) + ExtendedOffset + ATSShift;
	RenderY = floor(CameraY) - SpinOffset + OverviewOffset;
	
	// Keep the camera inside its limits
	RenderX = clamp(RenderX, MinRenderX, MaxRenderX - Width);
	RenderY = clamp(RenderY, MinRenderY, MaxRenderY - Height);
	
	// Display camera on calculated positions
	camera_set_view_pos(view_camera[0], RenderX, RenderY)
}