function DiscordSetup()
{
	// Set initalisation flag
	PresenceReady = false;
	
	// Set details
	switch room 
	{
		case Stage_TZ:
			DetailsString = "TEST STAGE";
		break;
		default:
			DetailsString = "";
		break;
	}
	
	// Set data
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
	MainImage     = "orbinaut";
	MainImageDesc = "";
}