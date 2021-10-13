function StageGameplayProcess()
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
		var Length = array_length(AnimatedGraphics);
		for (var i = 0; i < Length; i += 2)
		{
			if fade_check(FadeActive) and !Stage.IsPaused
			{
				var AnimSpeed = 1 / AnimatedGraphics[i + 1];
			}
			else
			{
				var AnimSpeed = 0;
			}
			sprite_set_speed(AnimatedGraphics[i], AnimSpeed, spritespeed_framespergameframe);
		}
	}
	
	// Process player death
	if Player.Death
	{
		// Disable camera and timer
		Camera.Enabled = false;
		TimeEnabled    = false;
		
		// Check if player has fallen below bottom boundary
		if floor(Player.PosY) >= Stage.BottomBoundary + 32
		{	
			/* Since Sonic 3, the game checks if player has fallen below
			Camera.ViewY + Game.Height + 32 instead. That's a quick change so we
			didn't make a flag for it */
			
			if !EventTimer
			{
				// Subtract a life
				Player.Lives--;
				
				// If ran out of lives or time, start game/time over event
				if !Player.Lives or Time == 36000
				{
					IsGameOver = true;
					audio_bgm_stop(PriorityHigh, 0);
					audio_bgm_play(PriorityLow, GameOver, 0, 0);
				}
			}
			
			// Count timer
			EventTimer++;
			
			// Wai for 1 or 12 seconds
			if !IsGameOver and EventTimer == 60 or IsGameOver and EventTimer == 720
			{
				// Fade out
				fade_perform(FadeTo, ColourBlack, 1);
				
				// Stop all music
				audio_bgm_stop(PriorityLow,  0.5);
				audio_bgm_stop(PriorityHigh, 0.5);
			}
			
			if fade_check(FadeMax)
			{	
				// Clear special ring data
				Game.SpecialRingData = [];
				
				// If we have lives, restart the stage
				if Player.Lives != 0
				{
					room_restart();
					Game.Lives = Player.Lives;
					
					// Clear saved time on checkpoint if this event is time over
					if IsGameOver and array_length(Game.StarPostData)
					{
						Game.StarPostData[2] = 0;
					}
				}
				
				// If ran out of lives, reset data
				else
				{
					// Reset all saved data during the stage		
					Game.StarPostData    = [];
					Game.SpecialRingList = [];
					
					// If have continues, go to continue screen
					if Game.Continues
					{
						room_goto(Screen_Continue);
					}
					
					// If not, return to menu
					else
					{
						// Override save file if not in "no save" mode
						if Game.ActiveSave != -1
						{
							Game.Lives     = 3;
							Game.Score     = 0;
							Game.Continues = 0;
							
							gamedata_save(Game.ActiveSave);
						}
						room_goto(Screen_DevMenu);
					}
				}
			}	
		}
	}
}		