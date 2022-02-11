function ObjCollisionTriggerStartup()
{
	/* Variable Definitions	
	1. GroundOnly,     default = false		
	2. LeftDirection,  default = "None"	
	3. RightDirection, default = "None"			
	*/
	
	State   = 0;
	visible = false;
	
	// Set object properties
	if object_index == CollisionTriggerV
	{
		object_set_triggerbox(-12, 12, -32, 32);
	}
	else if object_index == CollisionTriggerH
	{
		object_set_triggerbox(-32, 32, -12, 12);
	}
	object_set_unload(FlagPause);
}