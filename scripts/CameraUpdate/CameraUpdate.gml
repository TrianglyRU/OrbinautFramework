function CameraUpdate() 
{	
	// Exit if camera is disabled
	if !Enabled
	{
		exit;
	}
	
	// Calculate final view position
	ViewX = clamp(PosX + ExtendedOffset,			  0, room_width  - Game.Width);
	ViewY = clamp(PosY - SpinOffset + OverviewOffset, 0, room_height - Game.Height);
	
	// Update camera position
	camera_set_view_pos(view_camera[0], ViewX, ViewY);
}