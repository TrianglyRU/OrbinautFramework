function StageActiveProcess()
{	
	// Check if we should update the stage or not
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
				player_damage(false, false, true);
			}
		}	
	}
	
	// Process animated graphics
	if AnimatedGraphics != noone
	{
		for (var i = 0; i < array_length(AnimatedGraphics); i += 2)
		{
			var AnimSpeed = fade_check(FadeNone) and !Stage.IsPaused ? 1 / AnimatedGraphics[i + 1] : 0;
			
			sprite_set_speed(AnimatedGraphics[i], AnimSpeed, spritespeed_framespergameframe);
		}
	}
	
	// Process synced animations
	if !Stage.IsPaused and fade_check(FadeNone)
	{
		AnimationTime++;
	}
	
	// Process player death
	if Player.Death
	{
		// Disable camera and timer
		Camera.Enabled = false;
		TimeEnabled    = false;
		
		// Check if player has fallen below stage boundary
		if floor(Player.PosY) >= Stage.BottomBoundary
		{	
			if !EventTimer
			{
				// Subtract a life
				Player.Lives -= 1;
				
				// If ran out of lives or time, start game/time over event
				if !Player.Lives or Time == 36000
				{
					IsGameOver = true;
					audio_bgm_stop(PriorityHigh, 0);
					audio_bgm_play(PriorityLow, GameOverMusic, noone);
				}
			}
			
			// Fade out after 1 or 10 seconds
			if !IsGameOver and EventTimer == 60
			or  IsGameOver and EventTimer == 600
			{
				fade_perform(FadeTo, FadeBlack, 1);
				
				// Stop all music
				audio_bgm_stop(PriorityLow,  0.5);
				audio_bgm_stop(PriorityHigh, 0.5);
			}
			EventTimer++;
			
			if fade_check(FadeMax)
			{	
				if Player.Lives != 0
				{
					// Clear time if it is time over
					if IsGameOver
					{
						Game.Time = 0;
					}
					Game.Lives = Player.Lives;
					
					// Restart the stage
					room_restart();
				}
				else
				{
					// Reset game data
					Game.StarpostID     = false;
					Game.Time	        = 0;
					Game.StageBoundary  = 0;
					Game.SpecialRingIDs = [];
					Game.PlayerPosition = [];
					
					// If ran out of lives and have continues, go to continue screen
					if Game.Continues
					{
						Game.StarpostID     = false;
						Game.Time	        = 0;
						Game.StageBoundary  = 0;
						Game.SpecialRingIDs = [];
						Game.PlayerPosition = [];
					
						room_goto(Continue);
					}
					
					// If have nothing, return to menu
					else
					{
						// Override save file if not in "no save" mode
						if Game.ActiveSave != -1
						{
							gamedata_save(Game.ActiveSave, Game.Character, Stage.ZoneID, 0, 3, 0, 0);
						}
						room_goto(DevMenu);
					}
				}
			}	
		}
	}
}		