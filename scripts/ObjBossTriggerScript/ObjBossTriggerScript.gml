function ObjBossControllerScript()
{
	// Always setforce right boundary if object exist
	Stage.TargetRightBoundary = x + max(Screen.Width / 2, ArenaWidth  / 2);
	
	// Check if player ran past the trigger
	if !BossTriggered
	{
		if object_player_overlap(CollisionTriggerbox)
		{
			// Reserve current boundaries
			ReservedTopBound    = Stage.TopBoundary;
			ReservedBottomBound = Stage.BottomBoundary;
			
			// Stop music and play boss theme
			audio_bgm_mute(TypeNormal, 0.5);
			audio_bgm_play(Boss, 0, TypePriority); 
			
			// Spawn boss
			switch room
			{
				case MQZ0:
				case MQZ1:
				case MQZ2:
					instance_create(x, y - 184, Orboss);
				break;
				default: break;
			}
			
			BossTriggered = true;
		}
	}
	
	// Check if boss is active
	else 
	{
		
		instance_deactivate_object(Signpost);
		instance_deactivate_object(Capsule);
		
		// Set boundaries
		Stage.TargetLeftBoundary   = x - max(Screen.Width  / 2, ArenaWidth  / 2);
		Stage.TargetTopBoundary    = y - max(Screen.Height / 2, ArenaHeight / 2);
		Stage.TargetBottomBoundary = y + max(Screen.Height / 2, ArenaHeight / 2);
		
		// Check if the boss was defeated
		if BossDefeated
		{
			// Reset right and top boundaries
			Stage.TargetBottomBoundary = ReservedBottomBound;
			Stage.TargetTopBoundary	   = ReservedTopBound;
		
			// Stop all music
			audio_bgm_stop(TypePriority, 0);
			audio_bgm_stop(TypeNormal,   0);
			
			// Play stage music
			audio_bgm_play(Stage.StageMusic, Stage.StageMusicLooppoint, TypeNormal);
			
			instance_activate_object(Signpost);
			instance_activate_object(Capsule);
		
			// Destroy object
			instance_destroy();
		}
	}
}