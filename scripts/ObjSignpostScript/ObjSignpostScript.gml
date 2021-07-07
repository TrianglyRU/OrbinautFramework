function ObjSignpostScript()
{
	// Check for correct player
	if id.PlayerType == "Sonic & Tails" and Player.CharacterID == CharKnuckles
	or id.PlayerType == "Knuckles"		and Player.CharacterID != CharKnuckles
	{
		// Make invisible
		visible = false;
		
		// Exit the code
		exit;
	}
	
	// Activate on overlap and change stage state
	if !Active
	{
		if object_player_overlap(CollisionTriggerbox)
		{
			if Player.SuperState
			{
				Player.SuperState      = false;
				Player.SuperStateValue = 1;
			}
			Active		      = true;
			Stage.IsFinished  = true;
			
			// Play sound
			audio_sfx_play(sfxSignPost, false);
		}
	}
	else
	{	
		// Use as transition object
		Game.StageTransitionData[5] = id;
			
		// Count timer
		if ActiveTimer < 140
		{
			ActiveTimer++;
		}
		
		// Spawn stars
		switch ActiveTimer 
		{
			case   2: instance_create_depth(x - 23, y - 14, depth - 1, RingSparkle); break;
			case  14: instance_create_depth(x + 7,  y + 7,  depth - 1, RingSparkle); break;
			case  26: instance_create_depth(x - 14, y,      depth - 1, RingSparkle); break;
			case  38: instance_create_depth(x + 23, y - 7,  depth - 1, RingSparkle); break;
			case  50: instance_create_depth(x,      y - 7,  depth - 1, RingSparkle); break;
			case  62: instance_create_depth(x + 14, y - 1,  depth - 1, RingSparkle); break;
			case  74: instance_create_depth(x - 23, y + 7,  depth - 1, RingSparkle); break;
			case  86: instance_create_depth(x + 23, y + 14, depth - 1, RingSparkle); break;
			case  98: instance_create_depth(x - 23, y - 14, depth - 1, RingSparkle); break;
			case 110: instance_create_depth(x + 7,  y + 7,  depth - 1, RingSparkle); break;
			case 122: instance_create_depth(x - 14, y,      depth - 1, RingSparkle); break;
		}		
	}
	
	// Set boundaries
	if floor(Player.PosX) > (x - Screen.Width * 1.5 + 64) + Screen.Width / 2
	{
		Stage.TargetLeftBoundary  = x - Screen.Width * 1.5 + 64;
		Stage.TargetRightBoundary = x + Screen.Width / 2;
	}
	if Active
	{
		Stage.TargetLeftBoundary = x - (Screen.Width / 2);
	}
}