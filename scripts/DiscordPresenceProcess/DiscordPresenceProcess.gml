function DiscordPresenceProcess()
{
	// Exit if Rich Presence support is disabled
	if Game.RichPresenceSupport
	{
		exit;
	}
	
	// Call async event
	np_update();
	
	// Update Rich Presence
	if !PresenceReady and global.DiscordEvent == "DiscordReady"
	{	
		PresenceReady = true;
		
		np_clearpresence();
		np_setpresence_timestamps(global.DiscordTime, 0, false);
		np_setpresence_more(MainImageDesc, SmallImageDesc, false);
		np_setpresence(StateString, DetailsString, MainImage, SmallImage);
	}
}