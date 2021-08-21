function ObjSpindashDustStartup()
{
	// Set object depth
	object_set_depth(Player, true);
	
	// Match player facing direction
	image_xscale = Player.Facing;
}