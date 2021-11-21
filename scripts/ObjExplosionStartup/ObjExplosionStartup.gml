function ObjExplosionSetup()
{
	// Set object depth
	object_set_depth(Player, 1);
	
	// Set animation
	animation_play(sprite_index, 6, 0, 5);
}