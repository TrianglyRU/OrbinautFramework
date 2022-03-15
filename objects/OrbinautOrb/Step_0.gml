/// @description Main
// You can write your code in this editor
	
	// Ignore if player is under double spin shield
	if Player.DoubleSpinAttack
	{
		return;
	}
	
	// Damage player
	if object_check_touch(ColHitbox)
	{
		player_damage(false, false, false);
	}