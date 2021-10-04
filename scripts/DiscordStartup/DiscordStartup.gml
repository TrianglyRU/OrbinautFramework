function DiscordStartup()
{	
	// Get application ID. This one is for Orbianut and provides basic set of icons
	var DiscordAppID = "795659000645287996";
	
	// Initialise Rich Presence
	if !np_initdiscord(DiscordAppID, true, "0")
	{
		Game.RichPresenceSupport = false;
	}
	Game.DiscordTime = date_current_datetime();
}