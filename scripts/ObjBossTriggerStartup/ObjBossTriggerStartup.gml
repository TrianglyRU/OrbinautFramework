function ObjBossTriggerStartup()
{
	// Create variables
	BossDefeated		= 0;
	ReservedTopBound    = 0;
	ReservedBottomBound = 0;
	
	/* Variable Definitions
	1. ArenaWidth,  default = 400
	2. ArenaHeight, default = 224
	*/
	
	// Set object visibility
	visible = false;
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, 0, room_width);
	
	// Set object active range
	object_set_range(RangeFar, TypeUnload);
}