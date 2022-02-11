function ObjPrisonStartup()
{
	ExplosionTimer = irandom(32);
	TargetAnimal   = noone;
	State	       = 0;
	StateTimer	   = 0;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
	object_set_solidbox(32, 25, false);
	
	// Create button object
	ButtonObj = instance_create_child(x, y - 38, PrisonButton);
	with ButtonObj
	{
		object_set_depth(EggPrison, 0);
	}
}