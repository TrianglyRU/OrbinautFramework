/// @description Insert description here
// You can write your code in this editor

	var add = 45 * Numb;
	//x = floor(Parent.x + sin(Parent.Angle + add) * 35 * (dsin(Parent.Spin) >= 0 ? 1 : -1));
	x = floor(Parent.x + sin(Parent.Angle + add) * 35);
	y = floor(Parent.y + cos(Parent.Angle + add) * 35 * dsin(Parent.Spin));
	depth = Parent.depth + sign(sin(Parent.Angle + add + 90));
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false);
	}