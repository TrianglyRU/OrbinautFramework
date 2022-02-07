function ObjSpindashDustStartup()
{
	image_xscale = Player.Facing;
	
	// Set object properties
	object_set_depth(Player, 1);
	animation_play(sprite_index, 2, 0);
}