function DiscordProcess()
{
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}
	
	// Update Rich Presence
	if !Discord.PresenceReady and Game.DiscordEvent == "DiscordReady"
	{	
		np_clearpresence();
		np_setpresence_timestamps(Game.DiscordTime, 0, false);
		np_setpresence_more(Discord.MainImageDesc, Discord.SmallImageDesc, false);
		np_setpresence(Discord.StateString, Discord.DetailsString, Discord.MainImage, Discord.SmallImage);		
		
		Discord.PresenceReady = true;
	}
	
	// Call async event
	np_update();
}