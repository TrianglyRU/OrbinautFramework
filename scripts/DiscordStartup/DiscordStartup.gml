function DiscordStartup()
{	
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}
	
	// Get application ID. This one is for Orbianut and provides basic set of icons
	DiscordAppID = "795659000645287996";
	
	// Initialize Rich Presence
	if !np_initdiscord(DiscordAppID, true, "0")
	{
		Game.RichPresenceSupport = false;
	}
	
	Game.DiscordEvent = "";
	Game.DiscordTime = date_current_datetime();
}