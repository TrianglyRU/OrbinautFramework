function GameRoomInitialization()
{	
	// Initialize room viewport
	view_enabled[0] = true;
	view_visible[0] = true;
	camera_set_view_size(view_camera[0], Game.ResolutionWidth, Game.ResolutionHeight);
	surface_resize(application_surface,  Game.ResolutionWidth, Game.ResolutionHeight);
}