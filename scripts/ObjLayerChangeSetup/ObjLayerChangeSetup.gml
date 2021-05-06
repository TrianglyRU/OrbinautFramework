function ObjLayerChangeSetup()
{
	/* Variable Definitions	
	1. GroundOnly,     default = false		
	2. LeftDirection,  default = "None"	
	3. RightDirection, default = "None"			
	*/
	
	// Set hitbox
	object_set_hitbox(16, 64);
	
	// Set visibility
	object_set_visibility(false);
		
	// Render behind the player
	object_set_depth(Player, false);
}