function ObjBossControllerScript()
{
	// Check if player ran past the trigger
	if !BossTriggered
	{
		if object_player_overlap(CollisionTriggerbox)
		{
			// Set boundaries
			Stage.TargetLeftBoundary   = x - max(Screen.Width  / 2, ArenaWidth  / 2);
			Stage.TargetRightBoundary  = x + max(Screen.Width  / 2, ArenaWidth  / 2);
			Stage.TargetTopBoundary    = y - max(Screen.Height / 2, ArenaHeight / 2);
			Stage.TargetBottomBoundary = y + max(Screen.Height / 2, ArenaHeight / 2);
			
			// Stop music and play boss theme
			audio_bgm_stop(TypePriority, 0);
			audio_bgm_play(Boss, noone, 0, TypeNormal); 
			
			// Spawn boss
			switch room
			{
				case MQZ1:
					instance_create(x, y - 184, Orboss);
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
		
		// Play stage music
		audio_bgm_play(Stage.StageMusic, noone, Stage.StageMusicLooppoint, TypeNormal); 
		
		// Destroy object
		instance_destroy();
	}
}