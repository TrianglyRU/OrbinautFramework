function StageActUpdate()
{	
	// Restart the act upon player death
	// TODO: Correct stateTimer timings
	if Player.Death and State != ActStatePlayerDeath
	{
		TimeEnabled = false;
		StateTimer	= 0;
		State		= ActStatePlayerDeath;	
	}
	if State = ActStatePlayerDeath
	{
		if floor(Player.PosY) > Screen.RenderY + Screen.Height + 128
		{
			StateTimer++;
			if StateTimer = 1
			{
				screen_fade_perform(to, black, 1);
				audio_bgm_stop(BackgroundMusic, 0.5);
			}
			if StateTimer = 30
			{
				room_restart();
			}
		}
	}
	
	// Check for act end
	if State = ActStateFinished
	{	
		// Stop music
		audio_bgm_stop(BackgroundMusic, 2);
		
		// Disable time and reset timer and saved checkpoint
		if TimeEnabled
		{
			TimeEnabled			 = false;
			StateTimer			 = 0;
			Game.SavedCheckpoint = 0;
			Game.SavedPosition   = 0;
		}
		
		// Count timer until 60, that's when the result screen will appear
		if StateTimer != 60
		{
			StateTimer++;
		}		
	}
	
	// Proceed time counter
	if (TimeEnabled) Time++;
}