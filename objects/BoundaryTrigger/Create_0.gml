/// @description Startup
// You can write your code in this editor
	
	/* Variable Definitions	
	1. TriggerTop,    default = 0;	
	1. TriggerBottom, default = room_height;	
	*/

	// Set object properties
	object_set_unload(FlagPause);
	object_set_triggerbox(-16, 16, TriggerTop - y, TriggerBottom - y);