function ObjRollTriggerStartup()
{
	// Create variable
	Active = 0;
	
	/* Variable Definitions	
	1. XSize, default = 32
	2. YSize, default = 64		
	*/
	
	// Set object triggerbox
	object_set_triggerbox(0, XSize, 0, YSize);
	
	// Set object visibility
	visible = false;
}