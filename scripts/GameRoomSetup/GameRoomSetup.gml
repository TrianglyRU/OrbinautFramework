function GameRoomSetup()
{	
	// Enable room viewport 0 and make it visible
	view_enabled[0] = true;
	view_visible[0] = true;
	
	// Adjust room viewport to our resolution
	application_set_size(Game.ResolutionWidth, Game.ResolutionHeight);
}