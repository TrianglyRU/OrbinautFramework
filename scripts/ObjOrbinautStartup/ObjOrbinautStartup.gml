function ObjOrbinautStartup()
{
	PosX  = x;
	PosY  = y;
	Angle = 0;
	
	// Set object properties
	object_set_unload(FlagReset);
	object_set_depth(Player, 0);
	object_set_hitbox(8, 8);
	
	// Create orbs
	var ThisObject = id; 
	for (var i = 0; i < 4; i++)
	{
		Orb[i] = instance_create_child(x + 16 * dsin(90 * i), y + 16 * dcos(90 * i), OrbinautOrb);
		with Orb[i] 
		{
			object_set_depth(ThisObject, 1);
		}
	}
}