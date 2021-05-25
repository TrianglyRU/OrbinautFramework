/// @description Insert description here
// You can write your code in this editor

	var add = 45 * Numb;
	
	x = floor(Parent.x + sin(Parent.AngleX + add) * 35);
	
	var mode = cos(Parent.AngleY + add);
	//var mode = abs(cos(Parent.AngleY + add));
	//var mode = sin(Parent.AngleY + add);
	//var mode = abs(sin(Parent.AngleY + add));
	
	y = floor(Parent.y + mode * 35 * dsin(Parent.Spin));
	depth = Parent.depth + (Numb + 1) * (sin(Parent.AngleX + add + 90) >= 0 ? 1 : -1);
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false);
	}