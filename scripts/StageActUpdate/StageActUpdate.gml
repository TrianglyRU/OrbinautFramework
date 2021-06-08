function StageActUpdate()
{	
	// Check if act in progress
	if State != ActStateDefault
	{
		exit;
	}
	
	// Reset transition data
	Game.StageTransitionData[0] = 0;
	Game.StageTransitionData[1] = 0;
	Game.StageTransitionData[2] = 0;
	Game.StageTransitionData[3] = 0;
			
	Game.TransitionShiftPlayer[0] = 0;
	Game.TransitionShiftPlayer[1] = 0;
	Game.TransitionShiftCamera    = 0;

	// Player death
	if Player.Death
	{
		CameraEnabled = false;
		TimeEnabled   = false;
				
		if !(Player.Ysp > 0 and floor(Player.PosY) > Screen.CameraY + Screen.Height + 128)
		{
			StateTimer = 0;
		}
		else
		{	
			if StateTimer == 0
			{
				Player.Lives	-= 1;
				Game.GlobalLives = Player.Lives;
					
				fade_perform(to, black, 1);
				audio_bgm_stop(TypeAll, 2);
			}
					
			StateTimer++
			if StateTimer == 60
			{
				room_restart();
				audio_stop_all();
			}	
		}
	}
	
	// Procced animation timer
	else
	{
		AnimationTime++;
	}
			
	// Proceed stage time counter
	if TimeEnabled
	{
		Time++;
	}
		
		// Act finished
		/*case ActStateFinished:
		{
			// Stop music
			audio_bgm_stop(StageMusic, 2);
		
			// Disable stage time and reset saved positions
			if TimeEnabled
			{
				TimeEnabled			 = false;
				StateTimer			 = 0;
				Game.SavedCheckpoint = 0;
				Game.SavedPosition   = 0;
			}
		
			// Count timer
			var timeUntilResults = Stage.ActID == Stage.FinalActID ? 360 : 160;
			if StateTimer != timeUntilResults and StateTimer != -1
			{
				StateTimer++;
			}
		
			// If timer reached its limit, check if player is grounded
			else if Player.Grounded and StateTimer != -1
			{
				// Stop player and disable input
				Player.Xsp        = 0;
				Player.Ysp        = 0;
				Player.Inertia    = 0;	
				Input.IgnoreInput = true;
				Input.ResetInput  = true;
			
				// Play results music
				audio_bgm_play(ActClear, -1, -1);

				// Trigger results
				StateTimer = -1;
			}
		
			// Get stage transition data
			if Game.StageTransitions and Stage.ActID != Stage.FinalActID
			{
				// Get player's X and Y
				Game.StageTransitionData[0] = floor(Player.PosX) - (Screen.CameraX + Screen.Width / 2);
				Game.StageTransitionData[1] = floor(Player.PosY + Player.yRadius) - (Signpost.y + 24);
				
				// Get camera position
				Game.StageTransitionData[2] = floor(Player.PosY) - Screen.CameraY;
				
				// Get player's barrier
				Game.StageTransitionData[3] = Player.BarrierType;
				
				Game.TransitionShiftPlayer[0] = floor(Player.PosX) - (Screen.CameraX + Screen.Width / 2);
				Game.TransitionShiftPlayer[1] = floor(Player.PosY  + Player.yRadius) - (Signpost.y + 24);
				Game.TransitionShiftCamera    = floor(Player.PosY) - Screen.CameraY;
			
				// Shift player 1 pixel forwars if they are standing directly at sign's x coordnate
				// That might sound kinda FIX ME* but whatever
				if Game.TransitionShiftPlayer[0] == 0 or Game.StageTransitionData[0] == 0
				{
					Game.TransitionShiftPlayer[0] = 1
					Game.StageTransitionData[0]   = 1
				}
			}
			
			// Proceed animation timer
			if !Player.Death
			{	
				AnimationTime++;
			}
		}*/
}