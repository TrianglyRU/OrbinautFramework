function ObjSignpostMain()
{
	// Exit if playing as different character
	if id.PlayerType == "Sonic & Tails" and Game.Character == CharKnuckles
	or id.PlayerType == "Knuckles"		and Game.Character != CharKnuckles
	{
		visible = false;
		exit;
	}
	
	// Activate
	if !Active
	{
		if object_player_overlap(Triggerbox)
		{
			Active = 1;	
			audio_sfx_play(sfxSignPost, false);
			
			audio_bgm_stop(PriorityLow,  1);
			audio_bgm_stop(PriorityHigh, 1);
			
			Stage.TimeEnabled = false;
			Stage.AllowPause  = false;
			Stage.IsFinished  = 1;
			
			// Disable super state
			if Player.SuperState
			{
				Player.SuperState = false;
			}	
		}
	}
	else if Active == 1
	{	
		// Count timer
		ActiveTimer++;
		
		// Play animation
		if ActiveTimer < 62
		{
			animation_play(SpriteData[0], 1, 0);
		}
		else if ActiveTimer < 123
		{
			animation_play(SpriteData[1], 1, 0);
		}
		else
		{
			image_index = 0;
			Active		= 2;
			ActiveTimer = 0;
		}
		
		// Create sparkles
		if ActiveTimer mod 12 == 0 and SparkleToUse < 8
		{
			instance_create(x + SparkleX[SparkleToUse], y + SparkleY[SparkleToUse], RingSparkle);
			SparkleToUse++;
		}
	}
	
	// Finish the stage
	else if Active == 2
	{
		if Stage.IsFinished != 2
		{
			if (++ActiveTimer) >= 24
			{
				if Player.Grounded
				{
					// Play results music and set flags
					audio_bgm_play(PriorityLow, ActClearMusic, noone);
				
					Stage.IsFinished   = 2;
					Input.IgnoreInput  = true;	
					Player.Xsp		   = 0;
					Player.Ysp		   = 0;
					Player.Inertia     = 0;
					Player.SpindashRev = -1;
					Player.PeeloutRev  = -1;
				}
			}
		}
		
		// Set player animation
		else
		{
			Player.Animation = AnimActEnd;
		}
	}
	
	// Update stage boundaries
	if floor(Player.PosX) > (x - Game.Width * 1.5 + 64) + Game.Width / 2
	{
		Stage.TargetLeftBoundary  = x - Game.Width * 1.5 + 64;
		Stage.TargetRightBoundary = x + Game.Width / 2;
		
		if Active
		{
			Stage.TargetLeftBoundary = x - (Game.Width / 2);
		}
	}	
}