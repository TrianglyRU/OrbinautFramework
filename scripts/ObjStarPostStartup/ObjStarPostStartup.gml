function ObjStarPostStartup()
{
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	// Initialise variables
	State = 0;
	Angle = 180;
	
	// Set object properties
	object_set_triggerbox(-8, 8, -52, 52);
	object_set_depth(Player, 0);
	object_set_unload(FlagPause);
}