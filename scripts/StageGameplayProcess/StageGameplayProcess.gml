function StageGameplayProcess()
{	
	// Should we update our stage?
	if fade_check(StateActive) or IsPaused or Player.Death
	{
		DoUpdate = false;
	}
	else
	{
		DoUpdate = true;
	}

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
			if !fade_check(StateActive) and !Stage.IsPaused
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
		if floor(Player.PosY) >= Stage.BottomBoundary + 32
		{	
			/* In Sonic 3 and later, the game checks if player has fallen below
			Camera.ViewY + Game.Height + 32 instead */
			
			// If ran out of lives or time, start GAME OVER or TIME OVER event
			if !EventTimer
			{
				if !(--Player.Lives) or Time == 36000
				{
					IsGameOver = true;
					
					audio_bgm_stop(ChannelSecondary, 0);
					audio_bgm_play(ChannelPrimary, GameOver);
				}
			}
			EventTimer++;
			
			// Wait for 1 second if GAME OVER event isn't triggered, else wait for 12 seconds
			if !IsGameOver and EventTimer == 60 or IsGameOver and EventTimer == 720
			{
				fade_perform(ModeInto, BlendBlack, 1);
				
				audio_bgm_stop(ChannelPrimary,   0.5);
				audio_bgm_stop(ChannelSecondary, 0.5);
			}
			if fade_check(StateMax)
			{	
				if Player.Lives != 0
				{
					// Clear saved checkpoint time if we got TIME OVER
					if array_length(Game.StarPostData) and IsGameOver
					{
						Game.StarPostData[2] = 0;
					}
					Game.Lives = Player.Lives;
					
					// Restart the stage
					room_restart();
				}
				else
				{
					// Reset all saved data during the stage		
					Game.StarPostData    = [];
					Game.SpecialRingList = [];
					
					// If we have continues, go to continue screen
					if Game.Continues
					{
						room_goto(Screen_Continue);
					}
					
					// If not, return to DevMenu
					else
					{
						// Update game data of our save file
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
		Camera.Enabled = false;
		TimeEnabled    = false;
	}
}		