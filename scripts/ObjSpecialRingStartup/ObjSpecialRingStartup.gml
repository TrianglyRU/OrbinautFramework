function ObjSpecialRingStartup()
{
	// Initialise variables
	State   = 0;
	Timer   = 0;
	visible = false;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_hitbox(8, 16);
	object_set_depth(Player, 0);
	animation_play(spr_obj_specialring, 8, 0);
}