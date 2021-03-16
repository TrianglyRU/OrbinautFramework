function ObjLamppostSetup()
{
	// Init variables
	variable_init("Init");
	variable_init("Active");
	variable_init("Angle");
	
	/* Variable Definitions	
	1. LamppostID, default = 0		
	*/
	
	// Set object collision type
	object_set_collision(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 32);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}