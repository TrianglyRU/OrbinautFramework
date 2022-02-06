function ObjRollTriggerStartup()
{
	/* Variable Definitions	
	1. XSize, default = 16
	2. YSize, default = 32		
	*/
	
	State   = 0;
	visible = false;
	
	// Set object properties
	object_set_unload(TypePause);
	object_set_triggerbox(0, XSize * 16, 0, YSize * 16);
}