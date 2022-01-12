function DiscordSetup()
{
	// Remove controller if Rich Presence is disabled
	if !Game.RichPresenceSupport
	{
		instance_destroy(); exit;
	}
	PresenceReady = false;
	
	// Set stage data
	switch room 
	{
		case Stage_TZ:
			DetailsString = "TEST STAGE";
		break;
		default:
			DetailsString = "In Menus";
		break;
	}
	MainImage     = "orbinaut";
	MainImageDesc = "";
	
	// Set character data
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
		StateString    = "Playing as: " + string_upper(Char);
		SmallImageDesc = "";
		SmallImage     = Char;
	}
	else
	{
		StateString    = "";
		SmallImageDesc = "";
		SmallImage     = "";
	}
}