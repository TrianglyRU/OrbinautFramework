function ObjOrbinautOrbMain()
{
	// Damage on overlap
	if object_check_overlap(TypeHitbox)
	{
		player_damage(false, false, false);
	}
}