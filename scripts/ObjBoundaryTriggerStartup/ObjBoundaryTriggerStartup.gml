function ObjBoundaryTriggerStartup()
{
	/* Variable Definitions	
	1. TriggerTop,    default = 0;	
	1. TriggerBottom, default = room_height;	
	*/
	
	// Set object visibility
	visible = false;
	
	// Set object triggerbox
	object_set_triggerbox(-16, 16, TriggerTop - y, TriggerBottom - y);
}