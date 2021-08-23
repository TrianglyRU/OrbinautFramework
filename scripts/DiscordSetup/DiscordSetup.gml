function DiscordSetup()
{
	// Exit if Rich Presence support is disabled
	if !Game.RichPresenceSupport
	{
		exit;
	}
	
	// Set details
	switch room 
	{
		case TestStage:
			DetailsString = "TEST STAGE";
		break;
		default:
			DetailsString = "";
		break;
	}
	
	// Set state and small icon
	if instance_exists(Player)
	{
		switch Game.Character
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
				var Char = "?";
			break;
		}
		StateString = "Playing as: " + string_upper(Char);
		SmallImage  = Char;
	}
	else
	{
		StateString = "";
		SmallImage  = "";
	}
	
	// Set main icons
	MainImage = "orbinaut";
}