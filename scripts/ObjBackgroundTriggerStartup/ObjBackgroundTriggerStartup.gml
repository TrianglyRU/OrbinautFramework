function ObjBackgroundTriggerStartup()
{
	/* Variable Definitions	
	1. XSize, default = 4
	2. YSize, default = 4		
	*/
	
	// Set blank values
	State  = 0;
	BGType = 0;
	
	// Set object visibility
	visible = false;
	
	// Set object triggerbox
	object_set_triggerbox(0, XSize * 16, 0, YSize * 16);
	
	// Set object unload type
	object_set_unload(TypePause);
}