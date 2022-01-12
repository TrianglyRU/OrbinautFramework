function ObjStarPostPortalStartup()
{
	// Initialise variables
	Timer    = 0;
	State    = 0;
	Diameter = 0;
	
	// Set object properties
	object_set_hitbox(16, 4);
	object_set_depth(Player, 0);
}