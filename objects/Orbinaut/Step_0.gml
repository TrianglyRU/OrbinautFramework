/// @description Insert description here
// You can write your code in this editor
	
	// Check for hitbox overlap
	if object_player_overlap(CollisionHitbox)
	{
		// Damage player or be destroyed
		object_act_badnik(true, false);
	}
	
	Angle = (Angle + 4 * image_xscale) mod 360;
	PosX += image_xscale / 2;
	
	x = floor(PosX);
	y = floor(PosY);
	
	for(var i = 0; i < OrbNumb; i++)
	{
		var Parent = id;
		var Ang = Angle + OrbAng * i;
		with Orb[i]
		{
			x = Parent.x + 16 * dsin(Ang);
			y = Parent.y + 16 * dcos(Ang);
		}
	}
	
	