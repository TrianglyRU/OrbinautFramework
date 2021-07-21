/// @description Insert description here
// You can write your code in this editor
	
	x += Xsp;
	y += Ysp;
	
	if image_index >= 2
	{
		object_set_range(RangeClose, 2);
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false);
	}