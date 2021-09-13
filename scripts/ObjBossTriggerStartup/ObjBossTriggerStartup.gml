function ObjBossTriggerStartup()
{
	// Create variables
	BossDefeated		= 0;
	PreviousBottomBound = 0;
	
	/* Variable Definitions
	1. ArenaWidth,  default = 400
	2. ArenaHeight, default = -1
	*/
	
	// Replace sprite
	sprite_index = spr_blank;
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, -y, room_width - y);
	
	// Set object unload type
	object_set_unload(TypePause);
}