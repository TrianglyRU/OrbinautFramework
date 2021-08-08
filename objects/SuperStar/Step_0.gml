/// @description
// You can write your code in this editor
	
	if FollowPlayer
	{
		x = floor(Player.PosX);
		y = floor(Player.PosY);
	}
	
	animation_play(sprite_index, 2, 6);
	
	ObjectTimer--;
	if !ObjectTimer
	{
		if abs(Player.Inertia) >= Player.TopAcc
		{
			instance_create(floor(Player.PosX), floor(Player.PosY), SuperStar);
		}
		instance_destroy();
	}	