function ObjBossTriggerMain()
{
	// Always setforce right boundary if object exist
	Stage.TargetRightBoundary = x + max(Game.Width / 2, ArenaWidth  / 2);
	
	// Check if player ran past the trigger
	if Stage.IsBossfight == -1
	{
		if object_player_overlap(CollisionTriggerbox)
		{
			// Reserve current boundaries
			ReservedTopBound    = Stage.TopBoundary;
			ReservedBottomBound = Stage.BottomBoundary;
			
			// Stop music and play boss theme
			audio_bgm_stop(PriorityLow, 1);
			
			// Spawn boss
			switch room
			{
				case MQZ0:
					instance_create(x, y - 184, Orboss);
				break;
				default: break;
			}
			Stage.IsBossfight = true;
		}
	}
	
	// Check if boss is active
	else if Stage.IsBossfight == true
	{
		// Play boss music
		if !audio_bgm_is_playing(PriorityLow)
		{
			audio_bgm_play(PriorityLow, BossMusic, other); 
		}
		
		// Deactive signpost and egg prison
		instance_deactivate_object(Signpost);
		instance_deactivate_object(EggPrison);
		
		// Force boundaries
		Stage.TargetLeftBoundary   = x - max(Game.Width  / 2, ArenaWidth  / 2);
		Stage.TargetTopBoundary    = y - max(Game.Height / 2, ArenaHeight / 2);
		Stage.TargetBottomBoundary = y + max(Game.Height / 2, ArenaHeight / 2);
		
		// Check if the boss was defeated
		if BossDefeated
		{
			// Reset right and top boundaries
			Stage.TargetBottomBoundary = ReservedBottomBound;
			Stage.TargetTopBoundary	   = ReservedTopBound;
			Stage.TargetRightBoundary  = room_width;
			
			// Play stage music
			audio_bgm_play(PriorityLow, Stage.StageMusic, other);
			
			// Activate signpost and egg prison
			instance_activate_object(Signpost);
			instance_activate_object(EggPrison);
		
			// Destroy object
			instance_destroy();
			
			Stage.IsBossfight = false;
		}
	}
}