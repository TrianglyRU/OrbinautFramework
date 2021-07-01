function DiscordInformationSet()
{
	// Exit if Rich Presence is disabled in the framework
	if (!Game.RichPresenceSupport) exit;
	
	Ready = false;
	
	// Set details information block
	switch room 
	{
		case MQZ1: DetailsString = "MOONLIGHT QUADRANT 1" break;
		case MQZ2: DetailsString = "MOONLIGHT QUADRANT 2" break;
		default:   DetailsString = "UNKNOWN ZONE"		  break;
	}
	
	// Set state information block
	var ID = instance_exists(Player) ? Player.CharacterID : -1;
	switch ID
	{
		case CharSonic:    Char = "sonic"    break;
		case CharTails:	   Char = "tails"    break;
		case CharKnuckles: Char = "knuckles" break;
		default:		   Char = "unknown"  break;
	}
	
	// Set main image to show in Discord
	MainImg = "orbinaut";
	MainImgDesc = "";
	
	// Set additional image to show in Discord
	SmallImg = Char;
	SmallImgDesc = "";
	
	StateString = "Playing as: " + string_upper(Char);
}