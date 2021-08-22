function ObjStarPostStartup()
{
	// Create variables
	Active      = 0;
	Angle       = 0;
	ActiveCheck = 0;
	
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	// Set object triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set default lamp angle
	Angle = 180;
}