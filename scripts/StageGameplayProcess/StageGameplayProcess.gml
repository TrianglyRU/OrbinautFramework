function StageGameplayProcess()
{	
	// Process stage timer
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
				player_damage(false, false, true);
			}
		}	
	}
	
	// Process animated graphics
	if AnimatedGraphics != noone
	{	
		var Update = Game.UpdateAnimations; 
		var Length = array_length(AnimatedGraphics);
		
		for (var i = 0; i < Length; i += 2)
		{
			if Update
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
	
	/* In Sonic 3, the game checks if player has fallen
	below Camera.ViewY + Game.Height + 32 instead */
	
	// Process player's death event
	if Player.Death
	{
		Camera.Enabled = false;
		UpdateObjects  = false;
		TimeEnabled    = false;
		
		if floor(Player.PosY) < Stage.BottomBoundary + 32
		{
			return;
		}
		if !RestartTimer
		{
			// If ran out of lives or time, start event
			if !(--Player.Lives) or Time == 36000
			{
				RestartEvent = true;
					
				audio_bgm_stop(TypeSecondary, 0);
				audio_bgm_play(TypePrimary, GameOver);
			}
		}
		RestartTimer++;
			
		// Wait for 1 (or 12 if the event was triggered) seconds
		if RestartTimer == RestartEvent * 660 + 60
		{
			fade_perform(ModeInto, BlendBlack, 1);
				
			audio_bgm_stop(TypePrimary,   0.5);
			audio_bgm_stop(TypeSecondary, 0.5);
			
			// Stop animations
			Game.UpdateAnimations = false;
		}
		if fade_check(StateMax)
		{	
			if Player.Lives != 0
			{
				if array_length(Game.StarPostData) and RestartEvent
				{
					// Clear saved time on the Star Post if we got time over'ed
					Game.StarPostData[2] = 0;
				}
				Game.Lives = Player.Lives;
					
				room_restart();
			}
			else
			{		
				if Game.Continues
				{
					room_goto(Screen_Continue);
				}
				else
				{
					if Game.ActiveSave != -1
					{
						// Re-write game data
						Game.Lives     = 3;
						Game.Score     = 0;
						Game.Continues = 0;
							
						gamedata_save(Game.ActiveSave);
					}
					room_goto(Screen_DevMenu);
				}
					
				// Clear data saved during the stage
				Game.StarPostData    = [];
				Game.SpecialRingList = [];
			}
		}	
	}
}		