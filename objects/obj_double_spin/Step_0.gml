if !instance_exists(TargetPlayer)
{
	instance_destroy();
	exit;
}
	
if --attack_timer > 0
{
	exit;
}
	
if TargetPlayer.shield_state == SHIELD_STATE_DOUBLESPIN
{
	TargetPlayer.shield_state = SHIELD_STATE_DISABLED;
}
	
instance_destroy();