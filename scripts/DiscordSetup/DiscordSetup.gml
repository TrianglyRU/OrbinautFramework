function DiscordSetup()
{
	// Remove controller if Rich Presence is disabled
	if !Game.RichPresenceSupport
	{
		instance_destroy(); return;
	}
	PresenceReady = false;
	
	// Set stage data
	switch room 
	{
		case Stage_TZ:
			DetailsString = "Test Stage Act 1";
		break;
		case SStage_Template:
		case Screen_SStage:
			DetailsString = "Special Stage";
		break;
		case BStage_Template:
			DetailsString = "Bonus Stage";
		break;
		default:
			DetailsString = "In Menus";
		break;
	}
	
	if DetailsString != "In Menus"
	{
		switch Game.Character
		{
			case CharSonic:    
				var Char = "Sonic";
			break;
			case CharTails:	   
				var Char = "Tails";   
			break;
			case CharKnuckles: 
				var Char = "Knuckles";
			break;
			default:		  
				var Char = "";
			break;
		}
		if Game.Emeralds != 1
		{
			DetailsString += " (" + string(Game.Emeralds) + " Chaos Emeralds)";
		}
		else
		{
			DetailsString += " (" + string(Game.Emeralds) + " Chaos Emerald)";
		}
		StateString = Char;	
	}
	else
	{
		StateString = "";
	}
	
	MainImage      = "orbinaut";
	MainImageDesc  = "";
	SmallImageDesc = "";
	SmallImage     = "";
}