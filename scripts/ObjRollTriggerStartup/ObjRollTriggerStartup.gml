function ObjRollTriggerStartup()
{
	/* Variable Definitions	
	1. XSize, default = 16
	2. YSize, default = 32		
	*/
	
	// Set variable
	State = 0;
	
	// Set object visibility
	visible = false;
	
	// Set object triggerbox
	object_set_triggerbox(0, XSize * 16, 0, YSize * 16);
}