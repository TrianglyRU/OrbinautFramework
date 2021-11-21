function ObjDustPuffStartup()
{
	// Set flag
	State = 0;
	
	// Set object depth
	object_set_depth(Player, 1);
	
	// Set animation
	animation_play(sprite_index, 4, 0, 4);
}