function ObjPrisonStartup()
{
	// Set blank values
	State	       = 0;
	StateTimer	   = 0;
	
	// Set other variables
	ExplosionTimer = irandom(32);
	TargetAnimal   = noone;
	
	// Set object solidbox
	object_set_solidbox(32, 25, false);
		
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Create button object
	ChildObject	= instance_create(x, y - 38, PrisonButton);
}