function ObjBossControllerScript()
{
	// Check if player ran past the trigger
	if !BossTriggered
	{
		if floor(Player.PosX) > x
		{
			// Set boundaries
			Stage.TargetLeftBoundary   = x - max(Screen.Width  / 2, ArenaWidth  / 2);
			Stage.TargetRightBoundary  = x + max(Screen.Width  / 2, ArenaWidth  / 2);
			Stage.TargetTopBoundary    = y - max(Screen.Height / 2, ArenaHeight / 2);
			Stage.TargetBottomBoundary = y + max(Screen.Height / 2, ArenaHeight / 2);
		
			// Spawn boss
			switch room
			{
				case MQZ1:
					instance_create(x, y - 176, Orboss);
				break;
				default: break;
			}
			
			BossTriggered = true;
		}
	}
	
	// Check if the boss was defeated
	else if BossDefeated
	{
		// Reset right and top boundaries
		Stage.TargetRightBoundary = room_width;
		Stage.TargetTopBoundary	  = 0;
		
		// Destroy object
		instance_destroy();
	}
}