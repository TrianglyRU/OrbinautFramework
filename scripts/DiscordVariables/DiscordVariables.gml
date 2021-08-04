function DiscordVariables()
{
	// Exit if Rich Presence support is disabled
	if Game.RichPresenceSupport
	{
		exit;
	}
	
	// Instance variables list
	MainImage	   = "";
	MainImageDesc  = "";
	SmallImage	   = "";
	SmallImageDesc = "";
	StateString	   = "";
	DetailsString  = "";
	DiscordAppID   = "";
	PresenceReady  = 0;
	
	// Global variables list
	global.DiscordEvent = "";
	global.DiscordTime  = 0;
}	