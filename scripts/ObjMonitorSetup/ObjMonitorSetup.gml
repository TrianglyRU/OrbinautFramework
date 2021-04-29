function ObjMonitorSetup()
{
	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Set object solidbox
	object_set_solidbox(15, 15);
	
	// Render object behind player
	object_set_depth(Player, false);
	
	// Set PosY to real y position
	PosY = y;
}