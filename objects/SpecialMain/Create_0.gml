/// @description
// You can write your code in this editor
	
	RoomState  = 0;
	RoomTimer  = 0;
	RenderFlag = 0;
	Offset	   = [];

	// Turn screen white
	fade_perform(FadeTo, FadeWhite, 0);
	
	// Are we coming back from Special Stage?
	if Game.SpecialState
	{
		Offset[0] = -300;
		Offset[1] =  300;
		Offset[2] =  24;
		Offset[3] =  0;
		Offset[4] =  300;
		Offset[5] =  330;
		
		// Fade out
		fade_perform(FadeFrom, FadeWhite, 1);
		
		// Play music
		audio_play_sound(ActClearMusic, 0, false);
	}
	else
	{
		switch Game.Emeralds
		{
			/* Add redirection here */
			
			// Default redicrection
			default:
				room_goto(SpecialStage1);
			break;
		}
	}