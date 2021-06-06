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
	object_set_hitbox(16, 16);
	
	// Set object solidbox
	object_set_solidbox(15, 15);
	
	// Set object pdeth
	object_set_depth(Player, false);
	
	// Set default Y position
	PosY = y;
}