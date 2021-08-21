/// @description Insert description here
// You can write your code in this editor
	
	Angle = (Angle + 4 * image_xscale) mod 360;
	PosX += image_xscale / 2;
	
	x = floor(PosX);
	y = floor(PosY);
	
	for (var i = 0; i < OrbNumb; i++)
	{
		var Parent = id;
		var Ang = Angle + OrbAng * i;
		with Orb[i]
		{
			x = Parent.x + 16 * dsin(Ang);
			y = Parent.y + 16 * dcos(Ang);
		}
	}
	
	// Act as enemy
	object_act_enemy(EnemyBadnik);