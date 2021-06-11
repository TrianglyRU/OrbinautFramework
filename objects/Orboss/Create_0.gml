/// @description Insert description here
// You can write your code in this editor
	
	HP     = 10;
	AngleX = 0;
	AngleY = 0;
	Spin   = 90;
	Active = false;
	StateTimer = 128;
	State  = 0;
	PosX = x;
	PosY = y;
	if (!instance_exists(Orbstatue)) image_index = 2;
	
	object_set_solidbox(15, 15);
	object_set_hitbox(16, 16);
	object_set_depth(Player, false);
	
	for (var i = 0; i < 6; i++) 
	{
		var obj = instance_create_depth(x, y, depth, OrbossOrb);
		obj.Numb = i;
		obj.Parent = id;
	}