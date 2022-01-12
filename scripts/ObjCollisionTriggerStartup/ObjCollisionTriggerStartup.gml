function ObjCollisionTriggerStartup()
{
	/* Variable Definitions	
	1. GroundOnly,     default = false		
	2. LeftDirection,  default = "None"	
	3. RightDirection, default = "None"			
	*/
	
	// Initialise variables
	State   = 0;
	visible = false;
	
	// Set object properties
	object_set_triggerbox(-12, 12, -32, 32);
	object_set_unload(TypePause);
}