function StartupScreenSetup()
{
	// Create loading icon
	instance_create(Game.Width - 18, Game.Height - 18, LoadingIcon);
	
	// Set timer
	RoomTimer = 24;
}