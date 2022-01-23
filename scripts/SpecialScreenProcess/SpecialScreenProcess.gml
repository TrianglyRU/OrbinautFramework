function SpecialScreenProcess()
{
	// Check if we should exit
	if !Game.SpecialState or (!State and fade_check(StateActive))
	{
		exit;
	}
	switch State
	{
		case 0:
		{
			// Shift main text
			if Offset[0] < 0
			{
				Offset[0] += 15;
			}
			if Offset[1]
			{
				Offset[1] -= 15;
			}
			else if Offset[2]
			{
				Offset[2]--;
			}
			else if Offset[3] > -24
			{
				Offset[3] -= 0.5;
			}
			else
			{	
				// Shift counters
				if Offset[4]
				{
					Offset[4] -= 15;
				}
				if Offset[5]
				{
					Offset[5] -= 15;
				}
			
				// Render emeralds
				if RenderFlag == -1
				{
					RenderFlag = true;
				}
				else if RenderAlpha < 1
				{
					RenderAlpha += 0.1;
				}
			

				if !audio_bgm_is_playing(TypePrimary)
				{		
					if Game.SpecialScore
					{
						if !audio_sfx_is_playing(sfxScoreCount)
						{
							audio_sfx_play(sfxScoreCount, true);
						}
						Game.SpecialScore -= 100;
						Game.Score		  += 100;
					
						// Grant extra life for exceeding 50000 points
						if Game.Score mod 50000 == 0
						{
							Game.Lives++;
							audio_bgm_play(TypeSecondary, ExtraLife);
						}
					}
					else if Game.Emeralds != 7
					{
						audio_sfx_stop(sfxScoreCount);
						audio_sfx_play(sfxScoreTally, false);
						
						// Increment state
						State++;
					}
					else
					{
						audio_sfx_stop(sfxScoreCount);
						audio_sfx_play(sfxScoreTally, false);
						
						// Lower state
						State--;
					}
				}
			}
		}
		break;
		
		// Shift main text back to show "character can be super" message
		case -1:
		{
			if Offset[0] > -360
			{
				Offset[0] -= 30;
			}
			if Offset[1] < 360
			{
				Offset[1] += 30;
			}
			else
			{
				// Increment state
				State += 2;
			}
		}
		break;
		case 1:
		{
			// Shift "character can be super" message
			if Game.Emeralds == 7
			{
				if Offset[0] < 0
				{
					Offset[0] += 30;
				}
				if Offset[1]
				{
					Offset[1] -= 30;
				}
			}
			
			// Increment state and perform fade after 3 seconds
			if (++RoomTimer) == 180
			{
				State++
				
				fade_perform(ModeInto, BlendWhite, 1);
				audio_sfx_play(sfxSpecialWarp, false);
			}
		}
		break;
		case 2:
		{
			// Fade to black and increment state
			if fade_check(StateMax)
			{
				State++;
				fade_perform(ModeInto, BlendBlack, 1);
			}
		}
		break;
		case 3:
		{			
			if fade_check(StateMax) and !audio_sfx_is_playing(sfxSpecialWarp)
			{
				// Return to stage
				room_goto(Game.StageRoom);
				
				// Clear Special Stage flag
				Game.SpecialState = 0;
			}
		}
		break;
	}
	
	// Flick emeralds
	if RenderFlag != -1
	{
		RenderFlag = !RenderFlag;
	}
}