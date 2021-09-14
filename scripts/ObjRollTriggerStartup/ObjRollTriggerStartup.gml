function ObjRollTriggerStartup()
{
	/* Variable Definitions	
	1. XSize, default = 32
	2. YSize, default = 64		
	*/
	
	// Set variable
	State = 0;
	
	// Set object visibility
	visible = false;
	
	// Set object triggerbox
	object_set_triggerbox(0, XSize, 0, YSize);
}