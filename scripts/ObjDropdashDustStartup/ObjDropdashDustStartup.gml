function ObjDropdashDustStartup()
{
	// Match player facing direction
	image_xscale = Player.Facing;
	
	// Set object depth
	object_set_depth(Player, true);
}