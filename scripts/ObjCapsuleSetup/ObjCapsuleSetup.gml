function ObjCapsuleSetup()
{
	// Set object hitbox
	object_set_solidbox(32, 25, false);
		
	// Render behind the player
	object_set_depth(Player, false);
	
	object_set_range(RangeFar, TypeUnload);
	
	// Create button
	var ThisObject = id;
	ChildObject	   = instance_create(x, y - 38, PrisonButton);
	with ChildObject
	{
		object_set_depth(ThisObject, false);
	}
}