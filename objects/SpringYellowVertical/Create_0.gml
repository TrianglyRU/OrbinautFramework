/// @description Startup
// You can write your code in this editor
	
	LaunchForce = 10;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
	object_set_solidbox(16, 8, false);

	// Set animation to its last frame so we can simply restart it
	animation_play(sprite_index, 3, 3); image_index = 3;