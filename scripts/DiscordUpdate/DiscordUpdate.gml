function DiscordUpdate()
{
	if global.DiscordEvent != "DiscordReady"
	{
		global.DiscordEvent = async_load[? "event_type"];
	}
}