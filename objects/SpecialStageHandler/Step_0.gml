/// @description Insert description here
// You can write your code in this editor
	if Game.SpecialState
	{
		if !Palette.FadeStep
		{
			room_goto(SpecialControllerRoom);
		}
	}
	else
	{
		if Input.ABCPress
		{
			Game.SpecialState = 1;
			Game.SpecialScore = 10000;
			fade_perform(to, white, 1);
		}
		else if Input.StartPress
		{
			Game.SpecialState = 2;
			Game.SpecialScore = 1000;
			fade_perform(to, white, 1);
		}
	}