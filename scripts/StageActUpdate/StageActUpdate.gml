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
	Game.StageTransitionData[4] = false;
			
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
				if Player.Lives != 0
				{
					room_restart();
					audio_stop_all();
				}
				else
				{
					// Override save
					gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID, Player.Emeralds, 3, 0, 0);
					
					// Reset game state
					Game.GlobalCharacter = CharSonic;
					Game.GlobalScore	 = 0;
					Game.GlobalLives	 = 3;
					Game.GlobalConts	 = 0;
					Game.GlobalEmeralds  = 0;
					Game.SavedCheckpoint = false;
					Game.SavedPosition   = false;
				
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
	
	// Stop music
	audio_bgm_stop(TypeAll, 2);
		
	// Disable stage time and reset saved positions
	if TimeEnabled
	{
		TimeEnabled			 = false;
		StateTimer			 = 0;
		Game.SavedCheckpoint = 0;
		Game.SavedPosition   = 0;
	}
		
	// Count timer
	if StateTimer != -1
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
			audio_bgm_play(ActClear, noone, -1, TypeJingle);

			// Trigger results
			StateTimer = -1;
		}
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
		
		// Enable transition
		Game.StageTransitionData[4] = true;
	}
}		