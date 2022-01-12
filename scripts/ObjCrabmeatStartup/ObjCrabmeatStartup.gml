function ObjCrabmeatStartup()
{
	// Initialise variables
	PosX		   = x;
	PosY		   = y;
	Direction	   = image_xscale;
	Ysp			   = 0;
	State		   = 0;
	StateTimer	   = 0;
	PreviousSprite = 0;
	

	// Set object properties
	object_set_hitbox(16, 16);
	object_set_unload(TypeReset);
	object_set_depth(Player, 0);
}