function ObjDropdashDustStartup()
{
	// Match player facing direction
	image_xscale = Player.Facing;
	
	// Set object depth
	object_set_depth(Player, 1);
	
	// Set animation
	animation_play(sprite_index, 2, 0, 7);
}