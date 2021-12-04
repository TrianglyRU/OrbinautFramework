function ObjClearPanelMain()
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
			if floor(Player.PosX) > x
			{
				if Player.SuperState
				{
					// Restore stage music
					audio_bgm_play(ChannelPrimary, Stage.StageMusic);
					
					// Make player exit super form
					Player.SuperState = false;
				}
				Stage.TimeEnabled = false;
				Stage.IsFinished  = 1;
				
				// Increment state
				State++;
				
				// Play sound 
				audio_sfx_play(sfxClearPanel, false);
				
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
			if Player.Grounded
			{
				// Check if the player passed by the right boundary
				if floor(Player.PosX + Player.Xsp) > Stage.RightBoundary - 24
				{
					if Stage.IsFinished < 2
					{
						Stage.IsFinished = 2;
						
						// Play resuts music
						audio_bgm_play(ChannelPrimary, ActClear);
					}	
				}
				
				// Take away control from the player
				if !Input.IgnoreInput
				{
					Input.IgnoreInput = true;
				}
				
				// Force player movement
				else
				{
					Input.Right = true;
				}
			}
		}
	}
	
	// Update stage boundaries
	if !Stage.IsBossfight
	{
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
}