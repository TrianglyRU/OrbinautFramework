/// @description Insert description here
// You can write your code in this editor
	
	if !(--Timer)
	{
		image_index = 2;
		image_speed = 1;
		x += Xsp;
		y += Ysp;
	}
	else if Timer == 8
	{
		image_index = 1;
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false);
	}