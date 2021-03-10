function ObjRingSetup()
{	
	// Set instance as an object
	object_setup();
	
	// Set object solidity
	object_set_solidity(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 8);
	
	// Render behind the player
	object_set_depth(false);
}