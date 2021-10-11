function ObjStarPostEffectStartup()
{
	// Set blank values
	Timer  = 0;
	State  = 0;
	Radius = 0;
	
	// Set object hitbox
	object_set_hitbox(16, 4);
	
	// Set object depth
	object_set_depth(Player, false);
}