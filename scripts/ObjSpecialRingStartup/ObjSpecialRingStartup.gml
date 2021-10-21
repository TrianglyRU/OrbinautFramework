function ObjSpecialRingStartup()
{
	// Set blank values
	State = 0;
	Timer = 0;
	
	// Set object hitbox
	object_set_hitbox(8, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set animation
	animation_set(spr_obj_specialring, 8, 0, 0);
	
	// Make ring temporary invisible
	visible = false;
}