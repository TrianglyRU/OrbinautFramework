function StageActUpdate()
{	
	// Reset stage transition data
	if Game.StageTransitions and State == ActStateDefault
	{
		Game.StageTransferX = 0;
		Game.StageTransferY = 0;
	}
	
	// Restart the act upon player death
	// TODO: Correct stateTimer timings
	if Player.Death and State != ActStateRestart
	{
		CameraEnabled = false;
		TimeEnabled   = false;
		
		if floor(Player.PosY) > Screen.RenderY + Screen.Height + 128
		{
			State	   = ActStateRestart;
			StateTimer = 0;
		}
	}
	else if State == ActStateRestart	
	{
		if !StateTimer
		{
			fade_perform(to, black, 1);
		}
		else if StateTimer == 60
		{
			room_restart();
			audio_stop_all();
		}	
		StateTimer++;
	}
	
	// Check for act end
	if State == ActStateFinished
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
		var timeUntilResults = Stage.ActID ? 360 : 160;
		if StateTimer != timeUntilResults and StateTimer != -1
		{
			StateTimer++;
		}
		
		// If timer reached its limit, check if player is grounded
		else if Player.Grounded
		{
			// Stop player and disable input
			Player.Xsp        = 0;
			Player.Ysp        = 0;
			Player.Inertia    = 0;	
			Input.IgnoreInput = true;
			Input.ResetInput  = true;

			// Trigger results
			StateTimer = -1;
		}
	}
	
	// Proceed stage time counter
	if (TimeEnabled) Time++;
	
	// Proceed animation timer
	if !Player.Death and State != ActStateLoading and State != ActStateUnload
	{
		AnimationTime++;
	}	
}