function ObjBossTriggerStartup()
{
	// Create variables
	BossDefeated		= 0;
	PreviousBottomBound = 0;
	
	/* Variable Definitions
	1. ArenaWidth, default = 400
	*/
	
	// Replace sprite
	sprite_index = spr_blank;
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, -y, room_width - y);
	
	// Set object active range
	object_set_range(RangeFar, TypeUnload);
}