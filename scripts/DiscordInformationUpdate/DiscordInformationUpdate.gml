function DiscordInformationUpdate()
{
	// Exit if Rich Presence is disabled in the framework
	if (!Game.RichPresenceSupport) exit;
	
	// Call async event
	np_update();
	
	// Update Rich Presence
	if !Ready and global.DiscordEvent == "DiscordReady"
	{	
		Ready = true;
		
		np_clearpresence();
		
		np_setpresence_timestamps(global.DiscordTime, 0, false);
	
		np_setpresence_more(MainImgDesc, SmallImgDesc, false);
	
		// Should ALWAYS come the last!!
		np_setpresence(StateString, DetailsString, MainImg, SmallImg);
	}
}