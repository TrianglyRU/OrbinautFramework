function ObjDropdashDustStartup()
{
	// Match player facing direction
	image_xscale = Player.Facing;
	
	// Set object depth
	object_set_depth(Player, true);
	
	// Set animation
	animation_set(sprite_index, 2, 0, 7);
}