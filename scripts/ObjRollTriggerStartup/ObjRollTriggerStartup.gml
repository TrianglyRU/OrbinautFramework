function ObjRollTriggerStartup()
{
	/* Variable Definitions	
	1. XSize, default = 16
	2. YSize, default = 32		
	*/
	
	// Initialise variables
	State   = 0;
	visible = false;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_triggerbox(0, XSize * 16, 0, YSize * 16);
}