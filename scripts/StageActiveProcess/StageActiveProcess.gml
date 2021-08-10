function StageActiveProcess()
{	
	// Check if we should update stage or not
	if fade_check(FadeActive) or Player.Death or IsPaused
	{
		DoUpdate = false;
	}
	else
	{
		DoUpdate = true;
	}
	
	// Update event
	if DoUpdate
	{
		// Process timer
		if TimeEnabled
		{
			if (++Time) == 36000
			{
				if Game.DevMode
				{
					Time = 32400;
				}
				else
				{
					object_damage(false, false, true);
				}
			}
		}
		
		// Process sync animations
		AnimationTime++;
	}
	
	// Player death event
	if Player.Death
	{
		// Disable camera
		CameraEnabled = false;
		
		// Check if player is off-screen vertically
		if floor(Player.PosY) > Screen.CameraY + Screen.Height + 16
		{
			if (++EventTimer) == 60
			{
				Player.Rings  = 0;
				Player.Lives -= 1;
				
				if Time != 36000 and Player.Lives
				{
					fade_perform(FadeIn, FadeBlack, 36);
					audio_bgm_stop(PriorityLow,  0.5);
					audio_bgm_stop(PriorityHigh, 0.5);
				}
				else if !IsGameOver
				{
					IsGameOver = true;
					audio_bgm_stop(PriorityHigh, 0);
					audio_bgm_play(PriorityLow, GameOverMusic, noone);
				}
			}
			if IsGameOver and EventTimer == 780
			{
				fade_perform(FadeIn, FadeBlack, 36);
			}
			
			// Check if fade is at its peak
			if fade_check(FadeMax)
			{	
				// Subtract a life if player has it, and restart the stage
				if Player.Lives != 0
				{
					Game.Lives = Player.Lives;
					
					room_restart();
					audio_stop_all();
				}
				
				// If ran out of lives and have continues, go to continue screen
				else if Game.Continues
				{
					Game.Time	        = 0;
					Game.StageBoundary  = 0;
					Game.CheckpointID   = false;
					Game.PlayerPosition = false;
					
					room_goto(Continue);
				}
				else
				{
					// Override save file if not in 'no-save' mode
					if Game.ActiveSave != -1
					{
						gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID, 0, 3, 0, 0);
					}

					// Reset game state
					Game.Time	        = 0;
					Game.StageBoundary  = 0;
					Game.CheckpointID   = false;
					Game.PlayerPosition = false;
				
					audio_stop_all();
					room_goto(DevMenu);
				}
			}	
		}
	}
}		