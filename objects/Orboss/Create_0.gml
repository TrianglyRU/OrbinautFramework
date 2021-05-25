/// @description Insert description here
// You can write your code in this editor
	
	HP = 10;
	Timer = 0;
	AngleX = 0;
	AngleY = 0;
	Spin = 90;
	Active = false;
	
	image_index = instance_exists(Orbstatue) + 1;
	
	object_set_solidbox(15, 15);
	object_set_hitbox(16, 16);
	object_set_depth(Player, false);
	
	for (var i = 0; i < 6; i++) 
	{
		var obj = instance_create_depth(x, y, depth, Orb);
		obj.Numb = i;
		obj.Parent = id;
	}