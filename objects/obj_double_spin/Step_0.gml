if !instance_exists(player)
{
	instance_destroy();
}
else if --attack_timer <= 0
{
	if player.shield_state == SHIELD_STATE.DOUBLE_SPIN
	{
		player.shield_state = SHIELD_STATE.DISABLED;
	}
	
	instance_destroy();
}
else if animator.timer < 0
{
	visible = false;
}