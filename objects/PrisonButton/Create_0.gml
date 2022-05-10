/// @description Startup
// You can call your scripts in this editor

	State = 0;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(EggPrison, 0);
	object_set_solidbox(12, 8, false);
	
	animation_play(sprite_index, 3, 0);