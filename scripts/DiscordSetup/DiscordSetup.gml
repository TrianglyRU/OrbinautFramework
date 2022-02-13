function DiscordSetup()
{
	if !global.RichPresenceSupport
	{
		// Remove controller if Rich Presence is disabled
		instance_destroy(); return;
	}
	np_clearpresence();
	
	// Set details
	switch room 
	{
		case Stage_TVZ:
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
		switch global.Character
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
		if global.Emeralds != 1
		{
			DetailsString += " (" + string(global.Emeralds) + " Chaos Emeralds)";
		}
		else
		{
			DetailsString += " (" + string(global.Emeralds) + " Chaos Emerald)";
		}
		StateString = Char;	
	}
	else
	{
		StateString = "";
	}
	
	// Images
	MainImage      = "orbinaut";
	MainImageDesc  = "";
	SmallImageDesc = "";
	SmallImage     = "";
}