function DiscordVariables()
{	
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
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
}	