function ObjBossTriggerStartup()
{
	/* Variable Definitions
	1. ArenaWidth,  default = 400
	2. ArenaHeight, default = -1
	*/
	
	// Set variable
	BossDefeated = 0;
	
	// Hide sprite
	image_alpha = 0;
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, -y, room_width - y);
	
	// Set object unload type
	object_set_unload(TypePause);
}