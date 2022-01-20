function DiscordUpdate()
{
	if Game.DiscordEvent != "DiscordReady"
	{
		Game.DiscordEvent = async_load[? "event_type"];
	}
}