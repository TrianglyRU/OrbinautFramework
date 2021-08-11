function DiscordSetup()
{
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}
	
	// Set details information block
	switch room 
	{
		case MQZ0: 
			DetailsString = "MOONLIGHT QUADRANT 1";
		break;
		default:
			DetailsString = "UNKNOWN STAGE";
		break;
	}
	
	// Set state information block
	var ID = instance_exists(Player) ? Player.CharacterID : -1;
	switch ID
	{
		case CharSonic:    
			var Char = "sonic";
		break;
		case CharTails:	   
			var Char = "tails";   
		break;
		case CharKnuckles: 
			var Char = "knuckles";
		break;
		default:		  
			var Char = "unknown";
		break;
	}
	StateString = "Playing as: " + string_upper(Char);
	
	// Set icons
	MainImage  = "orbinaut";
	SmallImage = Char;
}