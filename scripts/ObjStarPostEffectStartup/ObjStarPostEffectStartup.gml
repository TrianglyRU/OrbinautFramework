function ObjStarPostEffectStartup()
{
	// Set blank values
	Timer    = 0;
	State    = 0;
	Diameter = 0;
	
	temp1  = 0;
	value5 = 0;
	value6 = 0;
	
	// Set object hitbox
	object_set_hitbox(16, 4);
	
	// Set object depth
	object_set_depth(Player, false);
}