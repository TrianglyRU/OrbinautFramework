function ObjClearPanelMain()
{
	if id.PlayerType == "Sonic & Tails" and global.Character == CharKnuckles
	or id.PlayerType == "Knuckles"		and global.Character != CharKnuckles
	{
		visible = false; return;
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
					// Make player exit their super form
					Player.SuperState = false;
					
					audio_bgm_play(TypePrimary, Stage.StageMusic);
				}
				Stage.TimeEnabled = false;

				audio_sfx_play(sfxClearPanel, false);
				animation_play(SpriteData[0], 1, 0);
				
				// Increment stage state
				Stage.IsFinished  = 1;
				
				// Increment state
				State++;
			}
		}
		break;
		case 1:
		{
			if (++StateTimer) == 62
			{
				// Switch to second animation
				animation_play(SpriteData[1], 1, 0);
			}
			else if StateTimer == 123
			{		
				animation_set(sprite_index, 0);
				
				// Increment state
				State++;
			}
		
			// Create as sparkle every 12th frame
			if StateTimer mod 12 == 0 and SparkleID < 8
			{
				instance_create(x + SparkleX[SparkleID], y + SparkleY[SparkleID], RingSparkle);
				SparkleID++;
			}
		}
		break;
		case 2:
		{
			if Player.Grounded
			{
				// Check if the player passed by the right boundary
				if floor(Player.PosX) > Stage.RightBoundary - 24
				{
					if Stage.IsFinished < 2
					{
						// Increment stage state
						Stage.IsFinished = 2;
					
						audio_bgm_play(TypePrimary, ActClear);
					}	
				}
				
				// Take control away from the player
				if !Input.IgnoreInput
				{
					Input.IgnoreInput = true;
				}
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
		if floor(Player.PosX) > (x - global.Width * 1.5 + 64) + global.Width / 2
		{
			Stage.TargetLeftBoundary  = x - global.Width * 1.5 + 64;
			Stage.TargetRightBoundary = x + global.Width / 2;
		
			if State > 0
			{
				Stage.TargetLeftBoundary = x - (global.Width / 2);
			}
		}
	}
}