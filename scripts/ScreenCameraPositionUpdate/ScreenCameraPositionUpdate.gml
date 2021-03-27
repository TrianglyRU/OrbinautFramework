function ScreenCameraPositionUpdate() 
{	
	// Set render positions
	RenderX = floor(ViewX) + ExtendedOffset;
	RenderY = floor(ViewY) - SpinOffset + OverviewOffset;
	
	// Keep the camera inside stage boundaries
	RenderX = clamp(RenderX, Stage.LeftBoundary, Stage.RightBoundary - Width);
	RenderY = clamp(RenderY, Stage.TopBoundary, Stage.BottomBoundary - Height);
	
	// Set camera on render coordinates
	camera_set_view_pos(view_camera[0], RenderX, RenderY)
}