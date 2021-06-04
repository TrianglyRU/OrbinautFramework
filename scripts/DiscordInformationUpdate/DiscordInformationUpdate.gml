function DiscordInformationUpdate()
{
	// Exit if Rich Presence is disabled in the framework
	if !Game.RichPresenceSupport
	{
		exit;
	}
	
	// Update Rich Presence
	discord_run_callbacks();
	discord_update_presence();
}