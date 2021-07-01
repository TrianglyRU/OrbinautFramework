function ObjBoundaryTriggerSetup()
{
	/* Variable Definitions	
	1. BottomBoundary, default = room_height		
	2. TopBoundary,    default = 0			
	*/
	
	// Set object triggerbox
	object_set_triggerbox(-16, 16, -512, 512);
	
	// Set object visibility
	visible = false;
}