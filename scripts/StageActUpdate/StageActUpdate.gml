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
		case MBZ:
		break;
	}
	
	// Kill player on time limit	
	if Time = 600 and TimeEnabled
	{
		// Set flags and disable camera
		Player.Grounded	      = false;
		Player.Rolling		  = false;
		Player.Jumping		  = false;
		Player.AllowCollision = false;
		Screen.CameraEnabled  = false;
		Stage.TimeEnabled     = false;
			
		// Perform movement
		Player.Xsp = -0.5;
		Player.Ysp = -7;	
			
		// Enter death script
		Player.Hurt = -1;
	}
	
	// TODO: Correct stateTimer timings
	// Restart on player death
	if Player.Hurt = -1 and State != ActStateRestart
	{
		State	   = ActStateRestart;
		StateTimer = 0;
	}
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
}