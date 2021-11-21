function ObjSuperStarStartup()
{
	// Set variable
	FollowPlayer = 0;
	
	// Set object depth
	object_set_depth(Player, 1);
	
	// Set animation
	animation_play(sprite_index, 2, 0, 5);
}