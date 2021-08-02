function StageActUpdate()
{	
	// Check if act is in progress
	if State != StageActive
	{
		exit;
	}
		
	// Player death
	if Player.Death
	{
		CameraEnabled = false;
		TimeEnabled   = false;
				
		if !(Player.Ysp > 0 and floor(Player.PosY) > Screen.CameraY + Screen.Height)
		{
			StateTimer = 0;
		}
		else
		{			
			StateTimer++
			
			if StateTimer == 60
			{
				Player.Lives -= 1;
					
				fade_perform(FadeIn, FadeBlack, 1);
				audio_bgm_stop(TypeAll, 1);
			}
			if fade_check(FadeMax)
			{		
				if Player.Lives != 0
				{
					Game.Lives = Player.Lives;
					
					room_restart();
					audio_stop_all();
				}
				else if Game.Continues
				{
					// Reset game state
					Game.Time	        = 0;
					Game.StageBoundary  = 0;
					Game.CheckpointID   = false;
					Game.PlayerPosition = false;
					
					// Goto continue screen
					room_goto(Continue);
				}
				else
				{
					// Override save
					if Game.ActiveSave != -1
					{
						gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID, 0, 3, 0, 0);
					}

					// Reset game state
					Game.Time	        = 0;
					Game.StageBoundary  = 0;
					Game.CheckpointID   = false;
					Game.PlayerPosition = false;
				
					audio_stop_all();
					room_goto(DevMenu);
				}
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
	
	// Exit the code if act is not finished
	if !IsFinished
	{
		exit;
	}
		
	// Disable stage time and reset saved positions
	if TimeEnabled
	{
		TimeEnabled	= false;
		StateTimer	= 0;
			
		// Stop music
		audio_bgm_stop(TypeAll, 2);
	}
		
	// Count timer
	if IsFinished != 2
	{
		if StateTimer != 160
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
			
			// Play results music
			audio_bgm_play(ActClear, -1, TypeNormal);

			// Trigger results
			IsFinished = 2;
			StateTimer = 0;
		}
	}
}		