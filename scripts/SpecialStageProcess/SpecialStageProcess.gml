function SpecialStageProcess()
{
	switch State
	{
		case 0:
		{
			if !fade_check(StateActive)
			{
				// Win
				if Input.ABCPress
				{
					State++;
					Game.SpecialState = 1;
					Game.SpecialScore = 10000;
			
					fade_perform(ModeInto, BlendWhite, 1);
					Game.Emeralds++;
			
					// Stop music
					audio_bgm_stop(ChannelPrimary,   0.5);
					audio_bgm_stop(ChannelSecondary, 0.5);
				}
		
				// Lose
				else if Input.StartPress
				{
					State++;
					Game.SpecialState = 2;
					Game.SpecialScore = 1000;
			
					fade_perform(ModeInto, BlendWhite, 1);
			
					// Stop music
					audio_bgm_stop(ChannelPrimary,   0.5);
					audio_bgm_stop(ChannelSecondary, 0.5);
				}
			}
		}
		break;
		case 1:
		{
			// Return to SS Screen to display results
			if fade_check(StateMax)
			{
				room_goto(Screen_SStage);
			}
		}
		break;
	}
}