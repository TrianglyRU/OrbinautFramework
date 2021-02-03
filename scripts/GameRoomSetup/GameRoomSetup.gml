function GameRoomSetup()
{	
	// Enable room viewport 0 and make it visible
	view_enabled[0] = true;
	view_visible[0] = true;
	
	// Adjust camera and surface to our resolution
	camera_set_view_size(view_camera[0], Game.ResolutionWidth, Game.ResolutionHeight);
	surface_resize(application_surface,  Game.ResolutionWidth, Game.ResolutionHeight);
}