function StageActiveProcess()
{	
	// Check if we should update stage or not
	DoUpdate = !(fade_check(FadeActive) or IsPaused or Player.Death);
	
	// Process stage time
	if DoUpdate and TimeEnabled
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
	
	// Process animated graphics
	if AnimatedGraphics[0] != noone
	{
		for (var i = 0; i < array_length(AnimatedGraphics); i += 2)
		{
			var AnimSpeed = fade_check(FadeNone) and !Stage.IsPaused ? 1 / AnimatedGraphics[i + 1] : 0;
			
			sprite_set_speed(AnimatedGraphics[i], AnimSpeed, spritespeed_framespergameframe);
		}
	}
	
	// Process synced animations
	if fade_check(FadeNone)
	{
		AnimationTime++;
	}
	
	// Player death event
	if Player.Death
	{
		// Disable camera and timer
		CameraEnabled = false;
		TimeEnabled   = false;
		
		// Check if player is off-screen vertically
		if floor(Player.PosY) > Screen.CameraY + Screen.Height + 256
		{	
			if !EventTimer
			{
				Player.Lives -= 1;
				
				if !Player.Lives or Time == 36000
				{
					IsGameOver = true;
					audio_bgm_stop(PriorityHigh, 0);
					audio_bgm_play(PriorityLow, GameOverMusic, noone);
				}
			}
			else if EventTimer == 60
			{
				if !IsGameOver
				{
					fade_perform(FadeIn, FadeBlack, 36);
					audio_bgm_stop(PriorityLow,  0.5);
					audio_bgm_stop(PriorityHigh, 0.5);
				}
			}
			else if EventTimer == 600
			{
				if IsGameOver
				{
					fade_perform(FadeIn, FadeBlack, 36);
				}
			}
			EventTimer++
			
			// Check if fade is at its peak
			if fade_check(FadeMax)
			{	
				// Restart the stage
				if Player.Lives != 0
				{
					Game.Lives = Player.Lives;
					
					// Clear time if Time Over
					if IsGameOver
					{
						Game.Time = 0;
					}
					
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