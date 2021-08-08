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
	
	// Player death event
	if Player.Death
	{
		// Disable camera
		CameraEnabled = false;
		
		// Check if player is off-screen vertically
		if Player.Ysp > 0 and floor(Player.PosY) > Screen.CameraY + Screen.Height
		{
			// Fade into black after 1 second
			EventTimer++
			if EventTimer == 60
			{
				Player.Lives -= 1;
					
				fade_perform(FadeIn, FadeBlack, 36);
				audio_bgm_stop(TypeAll, 1);
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
	
	// Update stage
	if DoUpdate
	{
		if TimeEnabled
		{
			Time++;
		}
		AnimationTime++;
	}
}		