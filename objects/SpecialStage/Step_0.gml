/// @description Main
// You can call your scripts in this editor
	
	switch State
	{
		case 0:
		{
			if !fade_check(StateActive)
			{
				// Win
				if Input.ABCPress
				{				
					global.Emeralds++;
					global.SpecialState = 1;
					global.SpecialScore = 10000;
					
					fade_perform(ModeInto, BlendWhite, 1);
			
					audio_bgm_stop(AudioPrimary,   0.5);
					audio_bgm_stop(AudioSecondary, 0.5);
					
					// Increment state
					State++;
				}
		
				// Lose
				else if Input.StartPress
				{
					global.SpecialState = 2;
					global.SpecialScore = 1000;
					
					fade_perform(ModeInto, BlendWhite, 1);
			
					audio_bgm_stop(AudioPrimary,   0.5);
					audio_bgm_stop(AudioSecondary, 0.5);
					
					// Increment state
					State++;
				}
			}
		}
		break;
		case 1:
		{
			// Return back to SS Screen to display results
			if fade_check(StateMax)
			{
				room_goto(Screen_SStage);
			}
		}
		break;
	}