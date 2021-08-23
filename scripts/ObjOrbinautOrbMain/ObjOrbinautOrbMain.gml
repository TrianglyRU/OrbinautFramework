function ObjOrbinautOrbMain()
{
	// Damage on overlap
	if object_check_overlap(Hitbox)
	{
		player_damage(false, false, false);
	}
}