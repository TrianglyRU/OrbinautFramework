function SpecialStageEnd()
{
	if !State
	{
		// Win
		if Input.ABCPress
		{
			Game.SpecialState = 1;
			Game.SpecialScore = 10000;
			
			fade_perform(FadeTo, ColourWhite, 1);
			
			State = 1;
			
			Game.Emeralds++;
		}
		
		// Lose
		else if Input.StartPress
		{
			Game.SpecialState = 2;
			Game.SpecialScore = 1000;
			
			fade_perform(FadeTo, ColourWhite, 1);
			
			State = 1;
		}
	}
	else if fade_check(FadeMax)
	{
		room_goto(Screen_SStage);
	}
}