function ObjCrabmeatStartup()
{
	// Create variables
	PosX      = x;
	State     = 0;
	PrevAnim  = 0;
	Timer     = 127;

	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	// Set animation
	animation_set(sprite_index, 16, 1, 0);
}