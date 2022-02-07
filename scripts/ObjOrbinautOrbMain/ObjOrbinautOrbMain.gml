function ObjOrbinautOrbMain()
{
	if Player.DoubleSpinAttack
	{
		return;
	}
	
	if object_check_touch(TypeHitbox)
	{
		player_damage(false, false, false);
	}
}