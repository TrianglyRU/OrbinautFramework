function ObjBossControllerScript()
{
	// Check if player ran past the trigger
	if !BossTriggered
	{
		if floor(Player.PosX) > x
		{
			// Activate bossfight
			BossTriggered = true;
			Stage.State   = ActStateBossfight;
		
			// Spawn boss
			switch room
			{
				case MQZ1:
					instance_create(x, y - 176, Orboss);
				break;
				default: break;
			}
		}
	}
	
	// Check if the boss was defeated
	else if BossDefeated
	{
		instance_destroy();
	}
}