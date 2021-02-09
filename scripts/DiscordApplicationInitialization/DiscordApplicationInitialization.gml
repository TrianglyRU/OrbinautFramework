function DiscordApplicationInitialization()
{	
	// Do not perform if RP is disabled in the framework
	if (!Game.RichPresenceSupport) exit;
	
	// Application ID. Use yours
	var DiscordAppId = "795659000645287996";
	var SteamAppId	 = ""; 
	
	// Proceed initial
	discord_init(DiscordAppId, SteamAppId);
}