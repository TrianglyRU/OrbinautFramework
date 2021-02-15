function DiscordInformationSet()
{
	// Do not perform if RP is disabled in the framework
	if Game.RichPresenceSupport = false exit;
	
	// Set application icon using its ID
	discord_set_large_image("orbinaut", "");
	
	// Set small icon using its ID. Uncomment if needed
	// discord_set_small_image("sonic", "");
	
	// Set details strings (current zone)
	switch room 
	{
		case GameStart: 
			DetailsString = "";
		break;
		case MBZ:
			DetailsString = "Moonlight Base Zone"; 
		break;
		case MBZ2:
			DetailsString = "Moonlight Base Zone 2"; 
		break;
	}
	discord_set_details(DetailsString);
	
	// Set state strings (currect character)
	var Char;
	switch Player.CharacterID 
	{
		case CharSonic: Char = "SONIC"; break
		case CharTails: Char = "TAILS"; break
	}
	StateString = "Playing as: " + string(Char);
	discord_set_state(StateString);	 
}