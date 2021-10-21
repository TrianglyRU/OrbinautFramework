function ObjSuperStarStartup()
{
	// Set variable
	FollowPlayer = 0;
	
	// Set object depth
	object_set_depth(Player, true);
	
	// Set animation
	animation_set(sprite_index, 2, 0, 5);
}