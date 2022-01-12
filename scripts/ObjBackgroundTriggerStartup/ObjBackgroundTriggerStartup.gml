function ObjBackgroundTriggerStartup()
{
	/* Variable Definitions	
	1. XSize, default = 4
	2. YSize, default = 4		
	*/
	
	// Initialise variables
	State   = 0;
	BGType  = 0;
	visible = false;
	
	// Set object properties
	object_set_triggerbox(0, XSize * 16, 0, YSize * 16);
	object_set_unload(TypePause);
}