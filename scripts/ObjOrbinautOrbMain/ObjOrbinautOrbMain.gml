function ObjOrbinautOrbMain()
{
	if Player.DoubleSpinAttack
	{
		return;
	}
	
	if object_check_touch(ColHitbox)
	{
		player_damage(false, false, false);
	}
}