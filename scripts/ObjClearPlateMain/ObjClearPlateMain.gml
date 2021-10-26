function ObjClearPlateMain()
{
	// Exit if playing as different character
	if id.PlayerType == "Sonic & Tails" and Game.Character == CharKnuckles
	or id.PlayerType == "Knuckles"		and Game.Character != CharKnuckles
	{
		visible = false;
		exit;
	}
	
	switch State
	{
		// Idle
		case 0:
		{
			if object_check_overlap(Triggerbox)
			{
				// Play sound 
				audio_sfx_play(sfxSignPost, false);
				
				// Restore stage music
				if !audio_bgm_is_playing(Stage.StageMusic)
				{
					audio_bgm_play(PriorityLow, Stage.StageMusic, other, other);
				}
				
				// Set stage flags
				Stage.TimeEnabled = false;
				Stage.IsFinished  = 1;
				
				// Make player exit out from super form
				if Player.SuperState
				{
					Player.SuperState = false;
				}
				
				// Increment state
				State++;
				
				// Set animation
				animation_play(SpriteData[0], 1, 0, 0);
			}
		}
		break;
		case 1:
		{
			// Count timer
			StateTimer++;
		
			// Set animation
			if StateTimer == 62
			{
				animation_play(SpriteData[1], 1, 0, 0);
			}
			
			// Increment state after 124 frames
			else if StateTimer == 123
			{
				State++;
				
				// Stop animation
				animation_set(sprite_index, 0);
			}
		
			// Create sparkles every 12 frames
			if StateTimer mod 12 == 0 and SparkleToUse < 8
			{
				instance_create(x + SparkleX[SparkleToUse], y + SparkleY[SparkleToUse], RingSparkle);
				SparkleToUse++;
			}
		}
		break;
		case 2:
		{
			if Stage.IsFinished != 2
			{
				if Player.Grounded
				{
					// Play results music
					audio_bgm_play(PriorityLow, ActClear, 0, 0);
				
					// Update flags
					Input.IgnoreInput  = true;
					Stage.IsFinished   = 2;	
					Player.Xsp		   = 0;
					Player.Ysp		   = 0;
					Player.Inertia     = 0;
					Player.SpindashRev = -1;
					Player.PeeloutRev  = -1;
				}
			}
		
			// Set player animation
			else
			{
				Player.Animation = AnimActEnd;
			}
		}
	}
	
	// Update stage boundaries
	if floor(Player.PosX) > (x - Game.Width * 1.5 + 64) + Game.Width / 2
	{
		Stage.TargetLeftBoundary  = x - Game.Width * 1.5 + 64;
		Stage.TargetRightBoundary = x + Game.Width / 2;
		
		if State
		{
			Stage.TargetLeftBoundary = x - (Game.Width / 2);
		}
	}	
}