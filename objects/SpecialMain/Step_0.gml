/// @description
// You can write your code in this editor

	// Exit if not from Special Stage
	if !Game.SpecialState
	{
		exit;
	}
	
	// Count timer
	RoomTimer++
	
	if !RoomState
	{
		// Fade to white
		if RoomTimer == 360
		{
			audio_play_sound(sfxSpecialWarp, 0, false);
			
			fade_perform(FadeIn, FadeWhite, 36);
			RoomState = 1;
		}
	}
	else if RoomState == 1
	{
		if fade_check(FadeMax)
		{
			RoomState = 2;
			fade_perform(FadeIn, FadeBlack, 36);
		}
	}
	else if fade_check(FadeMax)
	{
		Game.SpecialState = 0;
		room_goto(Game.CurrentStage[1]);
	}
	