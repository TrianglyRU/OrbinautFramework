function ObjCollisionTriggerStartup()
{
	/* Variable Definitions	
	1. GroundOnly,     default = false		
	2. LeftDirection,  default = "None"	
	3. RightDirection, default = "None"			
	*/
	
	// Set object triggerbox
	object_set_triggerbox(-8, 8, -32, 32);
	
	// Set object active range
	object_set_range(RangeClose, TypeUnload);
	
	// Set object visibility
	visible = false;
}