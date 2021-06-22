/// @description Insert description here
// You can write your code in this editor
	
	MaxHP  = 10;
	HP     = MaxHP;
	AngleX = 0;
	AngleY = 0;
	Spin   = 90;
	Active = false;
	StateTimer = 128;
	State  = 0;
	SinMove = 0;
	PosX = x;
	PosY = y;
	/*
	if !instance_exists(Orbstatue)
	{
		image_index = 2;
		Difficulty = 2;
	}
	else
	*/
	{
		Difficulty = 1;
	}
	
	object_set_hitbox(16, 16);
	object_set_depth(Player, false);
	
	var cnt = Difficulty == 1 ? 6 : 4;
	var ID = id;
	var ofst = 360 / cnt;
	for (var i = 0; i < cnt; i++) 
	{
		var OrbObj = instance_create_depth(x, y, depth, OrbossOrb);
		with OrbObj
		{
			Numb = i;
			Parent = ID;
			AngOfst = ofst;
		}
	}