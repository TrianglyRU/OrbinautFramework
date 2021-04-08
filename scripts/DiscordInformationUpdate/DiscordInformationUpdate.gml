function DiscordInformationUpdate()
{
	// Do not perform if RP is disabled in the framework
	if (!Game.RichPresenceSupport) exit;
	
	// Update
	discord_run_callbacks();
	discord_update_presence();
}