function ObjSignpostSetup()
{
	// Initialize variables
	Active	    isVar;
	ActiveTimer isVar;
	
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, -512, 512);
		
	// Set object depth
	object_set_depth(Player, false);
}