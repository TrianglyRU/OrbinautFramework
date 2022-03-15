/// @description Startup
// You can write your code in this editor

	/* Variable Definitions	
	1. BGType, default = "None"
	2. XSize,  default = 4
	3. YSize,  default = 4
	*/
	
	State   = 0;
	BGType  = 0;
	visible = false;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_triggerbox(0, XSize * 16, 0, YSize * 16);