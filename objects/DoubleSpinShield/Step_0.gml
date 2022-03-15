/// @description Main
// You can write your code in this editor
	
	// Destroy on animation end
	if image_index == 6
	{
		instance_destroy();
	}
	
	// Follow player
	else
	{
		x		     = floor(Player.PosX);
		y			 = floor(Player.PosY);
		image_xscale = Player.Facing;
	}