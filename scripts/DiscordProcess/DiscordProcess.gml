function DiscordProcess()
{
	if !PresenceReady and Game.DiscordEvent == "DiscordReady"
	{	
		// Update Rich Presence
		np_clearpresence();
		np_setpresence_timestamps(Game.DiscordTime, 0, false);
		np_setpresence_more(SmallImageDesc, MainImageDesc, false);
		np_setpresence(StateString, DetailsString, MainImage, SmallImage);		
		
		// Set flag
		PresenceReady = true;
	}
	
	// Call async event
	np_update();
}