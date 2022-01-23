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
					Game.Emeralds++;
					Game.SpecialState = 1;
					Game.SpecialScore = 10000;
					
					// Increment state
					State++;
					
					fade_perform(ModeInto, BlendWhite, 1);
			
					audio_bgm_stop(TypePrimary,   0.5);
					audio_bgm_stop(TypeSecondary, 0.5);
				}
		
				// Lose
				else if Input.StartPress
				{
					Game.SpecialState = 2;
					Game.SpecialScore = 1000;
					
					// Increment state
					State++;
			
					fade_perform(ModeInto, BlendWhite, 1);
			
					audio_bgm_stop(TypePrimary,   0.5);
					audio_bgm_stop(TypeSecondary, 0.5);
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