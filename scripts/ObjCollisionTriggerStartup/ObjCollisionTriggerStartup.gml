function ObjCollisionTriggerStartup()
{
	// Create variable
	TargetLayer = 0;
	
	/* Variable Definitions	
	1. GroundOnly,     default = false		
	2. LeftDirection,  default = "None"	
	3. RightDirection, default = "None"			
	*/
	
	// Set object triggerbox
	object_set_triggerbox(-16, 16, -32, 32);
	
	// Set object unload type
	object_set_unload(TypePause);
}