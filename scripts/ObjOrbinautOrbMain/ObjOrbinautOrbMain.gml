function ObjOrbinautOrbMain()
{
	// Damage on overlap
	if object_check_touch(TypeHitbox) and !Player.DoubleSpinAttack
	{
		player_damage(false, false, false);
	}
}