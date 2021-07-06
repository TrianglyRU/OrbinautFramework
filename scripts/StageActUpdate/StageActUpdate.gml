function StageActUpdate()
{	
	// Check if act in progress
	if State != ActStateDefault
	{
		exit;
	}
	
	// Reset transition data
	if !IsFinished
	{
		Game.StageTransitionData[0] = 0;
		Game.StageTransitionData[1] = 0;
		Game.StageTransitionData[2] = 0;
		Game.StageTransitionData[3] = 0;
		Game.StageTransitionData[4] = false;
		Game.StageTransitionData[5] = noone;
		Game.StageTransitionData[6] = 0;
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
				Player.Lives	-= 1;
				Game.Lives = Player.Lives;
					
				fade_perform(to, black, 1);
				audio_bgm_stop(TypeAll, 2);
			}
			if StateTimer == 90
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
					Game.Character      = CharSonic;
					Game.Score	        = 0;
					Game.Lives	        = 3;
					Game.Continues      = 0;
					Game.Emeralds       = 0;
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
	
	// Stop music
	audio_bgm_stop(TypeAll, 2);
		
	// Disable stage time and reset saved positions
	if TimeEnabled
	{
		TimeEnabled	= false;
		StateTimer	= 0;
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
			
			// Get stage transition data
			if Game.StageTransitions and Stage.ActID != Stage.FinalActID
			{
				// Get target object
				var TargetObject = Game.StageTransitionData[5];
		
				// Exit if no target object has been set
				if TargetObject == noone
				{
					exit;
				}
		
				// Get player's X and Y
				Game.StageTransitionData[0] = floor(Player.PosX) - (Screen.CameraX + Screen.Width / 2);
				Game.StageTransitionData[1] = floor(Player.PosY + Player.yRadius) - (TargetObject.y + 24);
				
				// Get camera position
				Game.StageTransitionData[2] = floor(Player.PosY) - Screen.CameraY;
				
				// Get player's barrier
				Game.StageTransitionData[3] = Player.BarrierType;
		
				// Get bottom boundary
				Game.StageTransitionData[6] = (Screen.CameraY + Screen.Height) - floor(Player.PosY + Player.yRadius);
		
				// Enable transition
				Game.StageTransitionData[4] = true;
			}
			
			// Play results music
			audio_bgm_play(ActClear, noone, -1, TypeJingle);

			// Trigger results
			IsFinished = 2;
			StateTimer = 0;
		}
	}
}		