/// @description
// You can write your code in this editor

	// Exit if not from Special Stage or active fade
	if !Game.SpecialState or (!RoomState and fade_check(FadeActive))
	{
		exit;
	}
	
	// Count timer
	RoomTimer++
	
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
		if Offset[4]
		{
			Offset[4] -= 15;
		}
		if Offset[5]
		{
			Offset[5] -= 15;
		}
		if RenderFlag == -1
		{
			RenderFlag = true;
		}
		else
		{
			RenderFlag = !RenderFlag;
		}
	}
	
	if !RoomState
	{
		// Fade to white
		if RoomTimer == 600
		{
			audio_play_sound(sfxSpecialWarp, 0, false);
			
			fade_perform(FadeTo, FadeWhite, 1);
			RoomState = 1;
		}
	}
	
	// Fade to black
	else if RoomState == 1
	{
		if fade_check(FadeMax)
		{
			RoomState = 2;
			fade_perform(FadeTo, FadeBlack, 1);
		}
	}
	
	// Unload
	else if fade_check(FadeMax)
	{
		Game.SpecialState = 0;
		room_goto(Game.CurrentStage[1]);
	}
	