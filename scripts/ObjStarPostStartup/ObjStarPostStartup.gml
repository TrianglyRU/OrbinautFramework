function ObjStarPostStartup()
{
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	// Set variables
	State = 0;
	Angle = 180;
	
	// Set object triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Set object depth
	object_set_depth(Player, 0);
	
	
}