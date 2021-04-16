function DiscordInformationSet()
{
	// Exit if Rich Presence is disabled in the framework
	if (!Game.RichPresenceSupport) exit;
	
	// Set main image to show in Discord
	discord_set_large_image("orbinaut", "");
	
	// Set additional image to show in Discord
	// discord_set_small_image("sonic", "");
	
	// Set details information block
	switch room 
	{
		case MBZ:
			DetailsString = "Moonlight Base Zone"; 
		break;
		case MBZ2:
			DetailsString = "Moonlight Base Zone 2"; 
		break;
		case HHZ:
			DetailsString = "Horizon Heights Zone"; 
		break;
	}
	discord_set_details(DetailsString);
	
	// Set state information block
	switch Player.CharacterID 
	{
		case CharSonic:    var Char = "SONIC";    break;
		case CharTails:	   var Char = "TAILS";    break;
		case CharKnuckles: var Char = "KNUCKLES"; break;
	}
	StateString = "Playing as: " + string(Char);
	discord_set_state(StateString);	 
}