function ObjLayerChangeSetup()
{
	// Set instance as an object
	object_setup();
	
	// Set object solidity
	object_set_solidity(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 32);
	
	// Make invisible
	object_set_visibility(false);
}