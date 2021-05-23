function ObjOrbstatueSetup()
{
	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Render object behind player
	object_set_depth(Player, false);
}