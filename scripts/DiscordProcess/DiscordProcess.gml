function DiscordProcess()
{
	if !PresenceReady and global.DiscordEvent == "DiscordReady"
	{	
		// Update Rich Presence
		np_clearpresence();
		np_setpresence_more(SmallImageDesc, MainImageDesc, false);
		np_setpresence(StateString, DetailsString, MainImage, SmallImage);	
		//np_setpresence_timestamps(global.DiscordTime, 0, false);
		
		// Set flag
		PresenceReady = true;
	}
	
	// Call async event
	np_update();
}