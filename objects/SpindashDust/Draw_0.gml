/// @description Blank
// You can write your code in this editor

	object_set_depth(Player, true);
	animation_play(sprite_index, 2, 1);
		
	x = floor(Player.PosX);
	y = floor(Player.PosY + Player.yRadius);
		
	image_xscale = Player.Facing;
		
	// Draw self
	draw_self();