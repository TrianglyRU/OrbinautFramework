function GameRoomSetup()
{	
	/* This is basic room/scene setup to make the process automatic, so
	you don't have to change viewport settings, for example */
	
	// Reset surfaces
	Game.BGSurf	  = -1;
	Game.MainSurf = -1;
	
	// Enable room viewport 0 and make it visible
	view_enabled[0] = true;
	view_visible[0] = true;
	
	// Adjust room viewport to our resolution
	application_set_size(Game.ResolutionWidth, Game.ResolutionHeight);
}