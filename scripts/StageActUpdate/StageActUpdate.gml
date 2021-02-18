function StageActUpdate()
{	
	// Proceed time counter
	if (TimeEnabled) Time++;

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
		}
		
		// Start timer
		StateTimer++
		switch StateTimer
		{	
			// Perform fade to black if it is not act 1
			case 160: 
			{
				screen_fade_perform(to, black, 1);
			}
			break;
			
			// Go to the next stage/act
			case 190:
			{
				if room = MBZ2
				{
					room_goto(DevMenu);
				}
				else
				{
					room_goto_next(); 
				}
			}
			break;
		}		
	}
}