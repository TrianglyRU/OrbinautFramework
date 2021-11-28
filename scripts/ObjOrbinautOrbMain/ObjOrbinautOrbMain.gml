function ObjOrbinautOrbMain()
{
	// Damage on overlap
	if object_check_overlap(TypeHitbox) and !Player.DoubleSpinAttack
	{
		player_damage(false, false, false);
	}
}