/// @description Main
// You can write your code in this editor

	// We should come back from the special stage to run this code!
	if !global.SpecialState
	{
		return;
	}
	
	if (!State and fade_check(StateActive))
	{
		return;
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
				
				if !audio_bgm_is_playing(AudioPrimary)
				{		
					if global.SpecialScore
					{
						if !audio_sfx_is_playing(sfxScoreCount)
						{
							audio_sfx_play(sfxScoreCount, true);
						}
						global.SpecialScore -= 100;
						global.Score		  += 100;
					
						// Grant extra life for exceeding 50000 points
						if global.Score mod 50000 == 0
						{
							global.Lives++;
							audio_bgm_play(AudioSecondary, ExtraLife);
						}
					}
					else if global.Emeralds != 7
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
			if global.Emeralds == 7
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
				// Return to stage or devmenu
				if array_length(global.SpecialRingData)
				{
					room_goto(global.StageRoom);
				}
				else
				{
					room_goto(Screen_DevMenu);
				}
				
				// Clear Special Stage flag
				global.SpecialState = 0;
			}
		}
		break;
	}
	
	// Flick emeralds
	if RenderFlag != -1
	{
		RenderFlag = !RenderFlag;
	}