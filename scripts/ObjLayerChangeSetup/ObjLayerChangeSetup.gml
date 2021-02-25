function ObjLayerChangeSetup()
{
	// Set instance as interactive object
	object_initialize(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 32);
	
	// Make invisible
	object_set_visibility(false);
}