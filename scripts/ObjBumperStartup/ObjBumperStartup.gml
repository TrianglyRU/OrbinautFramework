function ObjBumperStartup()
{
	// Initialise variables
	ScoreLimit = 10;
	State	   = 0;
	
	// Set object properties
	object_set_hitbox(8, 8);
	object_set_depth(Player, 1);
	object_set_unload(TypePause);
	
	// Set animation to its last frame so we can simply restart it
	animation_play(sprite_index, 4, 5); image_index = 5;
}