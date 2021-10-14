function SpecialScreenProcess()
{
	// Exit if not coming from Special Stage, or fade is active
	if !Game.SpecialState or (!State and fade_check(FadeActive))
	{
		exit;
	}
	
	switch State
	{
		case 0:
		{
			// Shift large text offsets
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
			
				// Start rendering emeralds
				if RenderFlag == -1
				{
					RenderFlag = true;
				}
				else if RenderAlpha < 1
				{
					RenderAlpha += 0.1;
				}
			
				// Start score count after audio stop playing
				if !audio_bgm_is_playing(PriorityLow)
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
							audio_bgm_play(PriorityHigh, ExtraLife, 0, 0);
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
		
		// Shift large text back to show "character can be super" message
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
			// Shift "Character can be super" message
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
				fade_perform(FadeTo, ColourWhite, 1);
				
				// Play warp sound
				audio_sfx_play(sfxSpecialWarp, false);
			}
		}
		break;
		case 2:
		{
			// Fade to black
			if fade_check(FadeMax)
			{
				fade_perform(FadeTo, ColourBlack, 1);
				
				// Increment state
				State++;
			}
		}
		break;
		case 3:
		{
			// Return to stage
			if fade_check(FadeMax) and !audio_sfx_is_playing(sfxSpecialWarp)
			{
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