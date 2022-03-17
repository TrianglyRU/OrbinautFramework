/// @description Startup
// You can write your code in this editor
	
	/* Variable Definitions	
	1. GroundOnly,    default = false		
	2. UpDirection,   default = "None"	
	3. DownDirection, default = "None"			
	*/
	
	State = 0;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_triggerbox(-32, 32, -12, 12);