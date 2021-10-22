function ObjMotobugStartup()
{
	// Set variables
	PosX  = x;
	PosY  = y;
	State = 0;
	Timer = 16;
	
	// Set object hitbox
	object_set_hitbox(20, 17);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	// Set animation
	animation_play(sprite_index, 8, 0, 0);
}