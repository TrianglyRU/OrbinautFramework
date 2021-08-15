function ObjSpindashDustScript()
{
	// Render above player
	object_set_depth(Player, true);
	
	// Play animation
	animation_play(sprite_index, 2, 1);
	
	// Follow player
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY + Player.RadiusY);	
	image_xscale = Player.Facing;
	
	// Destroy if player is airborne
	if !Player.Grounded or Player.Spinning or Player.SpindashRev == -1
	{
		instance_destroy();
	}
}