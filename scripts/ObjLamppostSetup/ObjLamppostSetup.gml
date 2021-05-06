function ObjLamppostSetup()
{
	// Create variables
	Init   _init;
	Active _init;
	Angle  _init;
	
	/* Variable Definitions	
	1. LamppostID, default = 0		
	*/
	
	// Set triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Set visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}