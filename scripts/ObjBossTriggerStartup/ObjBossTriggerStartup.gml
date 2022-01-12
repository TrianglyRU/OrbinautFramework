function ObjBossTriggerStartup()
{
	/* Variable Definitions
	1. ArenaWidth,  default = 400
	2. ArenaHeight, default = -1
	3. Template,    default = true
	*/
	
	// Initialise variables
	BossDefeated = 0;
	image_alpha  = 0;
	
	// Set object properties
	object_set_unload(TypePause);
}