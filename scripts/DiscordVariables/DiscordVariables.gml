function DiscordVariables()
{	
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}
	
	// Create variables
	MainImage	   = "";
	MainImageDesc  = "";
	SmallImage	   = "";
	SmallImageDesc = "";
	StateString	   = "";
	DetailsString  = "";
	PresenceReady  = 0;
}	