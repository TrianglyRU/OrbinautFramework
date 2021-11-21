function ObjPrisonStartup()
{
	// Set blank values
	State	     = 0;
	Timer	     = 0;
	ExplDelay    = 0;
	TargetAnimal = 0;
	
	// Set object solidbox
	object_set_solidbox(32, 25, false);
		
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Create button object
	ChildObject	= instance_create(x, y - 38, PrisonButton);
}