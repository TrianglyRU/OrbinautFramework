/// @description Insert description here
// You can write your code in this editor
	
	fade_perform(from, black, 0);
	switch Game.SpecialState
	{
		case 0: 
			room_goto(SpecialStage);
		break;
		case 1:
			Game.Emeralds++;
			Game.SpecialScore = 0;
			Game.SpecialState = 0;
			fade_perform(to, black, 1);
		break;
		case 2: 
			Game.SpecialScore = 0;
			Game.SpecialState = 0;
			fade_perform(to, black, 1);
		break;
	}