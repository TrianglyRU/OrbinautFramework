/// @description Insert description here
// You can write your code in this editor

	if !State and distance_to_point(Player.PosX, Player.PosY) < 128
	{
		State = 1;
	}
	if State and image_xscale < 1
	{
		image_xscale += 0.025;
		image_yscale += 0.025;
	}