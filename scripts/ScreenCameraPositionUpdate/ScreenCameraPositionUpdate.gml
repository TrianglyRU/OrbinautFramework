function ScreenCameraPositionUpdate() 
{	
	RenderX = floor(ViewX) + ExtendedOffset;
	RenderY = floor(ViewY) - SpinOffset + OverviewOffset;
	camera_set_view_pos(view_camera[0], RenderX, RenderY)
}