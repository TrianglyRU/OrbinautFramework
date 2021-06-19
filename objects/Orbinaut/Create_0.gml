/// @description Insert description here
// You can write your code in this editor

	object_set_hitbox(8, 8);
	object_set_depth(Player, false);
	
	var ThisBadnik = id;
	
	for(var i = 0; i < 4; i++)
	{
		var Ang = 90 * i;
		Orb[i] = instance_create(x + dsin(Ang), y + dcos(Ang), OrbinautOrb);
		with Orb[i] object_set_depth(ThisBadnik, true);
	}
	
	Angle = 0;
	PosX = x;
	PosY = y;