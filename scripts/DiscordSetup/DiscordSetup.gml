function DiscordSetup()
{
	// Remove controller if Rich Presence is disabled
	if !global.RichPresenceSupport
	{
		instance_destroy(); return;
	}
	PresenceReady = false;
	
	// Set stage data
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
	
	MainImage      = "orbinaut";
	MainImageDesc  = "";
	SmallImageDesc = "";
	SmallImage     = "";
}