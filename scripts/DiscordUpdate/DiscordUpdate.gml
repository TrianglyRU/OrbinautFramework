function DiscordUpdate()
{
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}

	// Capture async events
	if global.DiscordEvent != "DiscordReady"
	{
		global.DiscordEvent = async_load[? "event_type"];
	}
}