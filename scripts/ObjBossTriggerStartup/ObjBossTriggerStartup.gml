function ObjBossTriggerStartup()
{
	/* Variable Definitions
	1. ArenaWidth,  default = 400
	2. ArenaHeight, default = -1
	3. Template,    default = true
	*/
	
	// Set variable
	BossDefeated = 0;
	
	// Hide sprite
	image_alpha = 0;
	
	// Set object unload type
	object_set_unload(TypePause);
}