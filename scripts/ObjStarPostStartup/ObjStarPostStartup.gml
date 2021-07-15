function ObjStarPostStartup()
{
	// Create variables
	Active isBool;
	Angle  isReal;
	
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	// Set triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default lamp angle
	Angle = 180;
}