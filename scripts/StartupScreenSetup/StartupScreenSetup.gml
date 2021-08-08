function StartupScreenSetup()
{
	// Create loading icon
	instance_create(Game.ResolutionWidth - 18, Game.ResolutionHeight - 18, LoadingIcon);
	
	// Set timer
	RoomTimer = 1;
}