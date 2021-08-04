function DiscordPresenceStartup()
{	
	// Exit if Rich Presence support is disabled
	if Game.RichPresenceSupport
	{
		exit;
	}

	// Get application ID. Use yours!
	DiscordAppID = "795659000645287996"
	
	// Initialize Rich Presence using application ID
	if !np_initdiscord(DiscordAppID, true, "0")
	{
		Game.RichPresenceSupport = false;
	}
	
	// Set time
	global.DiscordTime = date_current_datetime();
}