function ObjItemboxSetup()
{
	// Initialize variables
	Airborne  isVar;
	Destroyed isVar;
	Ysp		  isVar;
	PosY	  isVar;
	
	/* Variable Definitions	
	1. BoxType, default = "Empty"
	*/
	
	// Set object hitbox
	object_set_hitbox(15, 17);
	
	// Set active range
	object_set_range(RangeFar, true);
	
	// Set object solidbox
	object_set_solidbox(14, 16);
	
	// Set object pdeth
	object_set_depth(Player, false);
	
	// Set default Y position
	PosY = y;
}