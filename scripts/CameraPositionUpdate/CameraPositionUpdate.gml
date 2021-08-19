function CameraPositionUpdate() 
{	
	// Exit if camera is disabled
	if !Enabled
	{
		exit;
	}
	
	// Calculate final view position
	if instance_exists(Stage)
	{
		ViewX = clamp(PosX + ExtendedOffset,			  Stage.LeftBoundary, Stage.RightBoundary - Game.Width);
		ViewY = clamp(PosY - SpinOffset + OverviewOffset, Stage.TopBoundary, Stage.BottomBoundary - Game.Height);
	}
	else
	{
		ViewX = clamp(PosX, 0, room_width  - Game.Width);
		ViewY = clamp(PosY, 0, room_height - Game.Height);
	}
	
	// Update camera position
	camera_set_view_pos(view_camera[0], ViewX, ViewY);
}