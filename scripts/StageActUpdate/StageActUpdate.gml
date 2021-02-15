function StageActUpdate()
{	
	// Proceed time counter
	if (TimeEnabled) Time++;
	
	// Perform super palette cycle
	if Player.isSuper
	{
		if Player.CharacterID = CharSonic
		{
			for (var i = 0; i < 4; i++) 
			{
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
			}
		}
		if Player.CharacterID = CharTails
		{
			for (var i = 0; i < 4; i++) 
			{
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
			}
		}
	}	
	
	// Perform stage palette cycle
	switch room
	{
		case MBZ: break;
	}
	
	// Kill player on time limit	
	if Time = 36000 and !Player.Death
	{
		// Set flags and disable camera
		Player.Grounded	      = false;
		Player.Rolling		  = false;
		Player.Jumping		  = false;
		Player.AllowCollision = false;
			
		// Perform movement
		Player.Xsp = -0.5;
		Player.Ysp = -7;	
			
		// Enter death script
		Player.Death = true;
	}
	
	// Set state flag to ActStateRestart if player died
	if Player.Death and State != ActStateRestart
	{
		Stage.TimeEnabled = false;
		StateTimer		  = 0;
		State			  = ActStateRestart;	
	}
	
	// Restart the act 
	// TODO: Correct stateTimer timings
	if State = ActStateRestart
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
		audio_bgm_stop(BackgroundMusic, 2);
		Game.SavedCheckpoint = 0;
		
		if TimeEnabled
		{
			StateTimer  = 0;
			TimeEnabled = false;
		}
		StateTimer++
		switch StateTimer
		{	
			case 160: 
				if ActID != 0
				{
					screen_fade_perform(to, black, 1);
				}
			break;
			case 190: 
				if room = MBZ2
				{
					room_goto(DevMenu);
				}
				else
				{
					room_goto_next(); 
				}
			break;
		}		
	}
}