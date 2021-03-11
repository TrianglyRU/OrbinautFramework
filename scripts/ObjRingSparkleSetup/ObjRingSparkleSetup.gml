function ObjRingSparkleSetup()
{
	// Set object collision type
	object_set_collision(SolidNone);
	
	// Set object visibility
	object_set_visibility(true);
	
	// Render above the player
	object_set_depth(true);
}