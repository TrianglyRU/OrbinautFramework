function ObjSpindashDustScript()
{
	// Render above player
	object_set_depth(Player, true);
	
	// Play animation
	animation_play(sprite_index, 2, 1);
	
	// Follow player
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY + Player.yRadius);	
	image_xscale = Player.Facing;
		
	// Draw self
	draw_self();
}