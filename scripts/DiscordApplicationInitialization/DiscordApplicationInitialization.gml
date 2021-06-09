function DiscordApplicationInitialization()
{	
	// Exit if Rich Presence is disabled in the framework
	if (!Game.RichPresenceSupport) exit;

	// Get application ID. Use yours!
	var DiscordAppId = "795659000645287996"
	
	// Initialize Rich Presence using application ID
	if (!np_initdiscord(DiscordAppId, true, "0")) Game.RichPresenceSupport = false;
	
	global.DiscordEvent = "";
	global.DiscordTime  = date_current_datetime();
}