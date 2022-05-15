/// @ Called in Discord Controller -> Room Start Event
function DiscordSetup()
{
	/* Please note that default ID provides some basic icons
	we made. For your own fangame, create your own application at Discord RP website!
	
	ID can be set in Discord -> Game Start Event */
	
	switch room 
	{
		case Stage_TSZ:
			TopString = "Test Stage";
		break;
		case SStage_Template:
		case Screen_SStage:
			TopString = "Special Stage";
		break;
		case BStage_Template:
			TopString = "Bonus Stage";
		break;
		default:
			TopString = "In Menus";
	}
	
	if TopString != "In Menus"
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
		}
		if global.Emeralds != 1
		{
			TopString += " (" + string(global.Emeralds) + " Chaos Emeralds)";
		}
		else
		{
			TopString += " (" + string(global.Emeralds) + " Chaos Emerald)";
		}
		BottomString = Char;	
	}
	else
	{
		BottomString = "";
	}
	
	// Set images
	MainImage      = "orbinaut";
	MainImageDesc  = "";
	SmallImageDesc = "";
	SmallImage     = "";
}