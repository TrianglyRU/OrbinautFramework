function ObjPrisonStartup()
{
	// Create variables
	var ThisObject = id;
	ChildObject    = 0;
	State	       = 0;
	Timer	       = 0;
	ExplDelay      = 0;
	
	// Set object solidbox
	object_set_solidbox(32, 25, false);
		
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(RangeFar, TypeUnload);
	
	// Create button object
	ChildObject	= instance_create(x, y - 38, PrisonButton);
	with ChildObject
	{
		object_set_depth(ThisObject, false);
	}
}