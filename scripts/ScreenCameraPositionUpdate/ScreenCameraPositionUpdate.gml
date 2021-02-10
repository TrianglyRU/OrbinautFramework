function ScreenCameraPositionUpdate() 
{	
	// Set render positions
	RenderX = floor(ViewX) + ExtendedOffset;
	RenderY = floor(ViewY) - SpinOffset + OverviewOffset;
	
	// Set camera on render coordinates
	camera_set_view_pos(view_camera[0], RenderX, RenderY)
}