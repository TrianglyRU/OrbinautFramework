function ObjOrbinautStartup()
{
	// Create variables
	var ThisBadnik = id;
	PosX  = 0;
	PosY  = 0;
	Angle = 0;
	Orb   = [];
	
	// Set default position
	PosX = x;
	PosY = y;
	
	// Set object hitbox
	object_set_hitbox(8, 8);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	// Spawn orbs
	for (var i = 0; i < 4; i++)
	{
		var Ang = 90 * i;
		
		Orb[i] = instance_create_children(x + 16 * dsin(Ang), y + 16 * dcos(Ang), OrbinautOrb, Orb);
		with Orb[i] 
		{
			// Set depth
			object_set_depth(ThisBadnik, true);
		}
	}
}