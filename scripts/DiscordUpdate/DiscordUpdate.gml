function DiscordUpdate()
{
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}

	// Capture async events
	if Game.DiscordEvent != "DiscordReady"
	{
		Game.DiscordEvent = async_load[? "event_type"];
	}
}