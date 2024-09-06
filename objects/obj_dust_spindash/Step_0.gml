
	if !instance_exists(TargetPlayer) || TargetPlayer.action != ACTION_SPINDASH
	{
		instance_destroy();
		exit;
	}