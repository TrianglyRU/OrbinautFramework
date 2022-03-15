/// @description Setup
// You can call your scripts in this editor
	
	if !global.RichPresenceSupport
	{
		// Remove controller if Rich Presence is disabled
		instance_destroy(); return;
	}
	
	np_clearpresence();
	
	// Set details
	switch room 
	{
		case Stage_TSZ:
			TopString = "Wireframe Valley";
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